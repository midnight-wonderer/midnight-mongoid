# frozen_string_literal: true

require 'active_support/core_ext/object'
require 'midnight/business_logic'

module Midnight
  module Mongoid
    DEFAULT_COMMAND_VALIDATOR = lambda(&:validate!)

    class Interactor
      def initialize(
        aggregate_key:,
        build_aggregate:,
        event_handler: Commons::NULL_EVENT_HANDLER,
        command_validator: DEFAULT_COMMAND_VALIDATOR,
        state_persistence: State,
        advance_state_metadata: lambda(&:advance_metadata),
        save_state: lambda(&:save!)
      )
        @aggregate_key = aggregate_key
        @build_aggregate = build_aggregate
        @event_handler = event_handler
        @command_validator = command_validator
        @state_persistence = state_persistence
        @advance_state_metadata = advance_state_metadata
        @save_state = save_state
        freeze
      end

      def call(*commands)
        commands.each(&@command_validator)
        transaction do |aggregate|
          commands.each(&aggregate.method(:dispatch))
          aggregate.pending_events
        end
      end

      private

      def transaction(&aggregate_operator)
        lazy_key = @aggregate_key.respond_to?(:call)
        state_record = if lazy_key
          @state_persistence.load(key: nil)
        else
          @state_persistence.load(key: @aggregate_key)
        end
        aggregate = @build_aggregate.call(
          state: state_record.state,
        )
        current_metadata = state_record.metadata
        pending_events = aggregate_operator.call(aggregate)
        return pending_events if pending_events.blank?
        state_record.state = aggregate.state
        @advance_state_metadata.call(state_record, pending_events)
        state_record._id = @aggregate_key.call if lazy_key
        begin
          pending_events
        ensure
          @save_state.call(state_record)
          persisted_metadata = state_record.metadata
          handler_metadata = { # support lazy generation of id
            **current_metadata.except(:state_id),
            **persisted_metadata.slice(:state_id),
          }
          @event_handler.call(
            pending_events,
            **handler_metadata,
          )
        end
      end
    end
  end
end
