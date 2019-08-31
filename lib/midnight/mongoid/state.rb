require 'active_support/core_ext/object'
require 'active_support/core_ext/hash'
require 'mongoid'

module Midnight
  module Mongoid
    class State
      include ::Mongoid::Document
      store_in collection: 'aggregate_states'

      field :state, type: ::Hash
      field :next_position, type: Integer, default: 1
      field :lock_version, type: Integer, default: 0

      def metadata
        {
          next_position: next_position,
          state_id: _id,
          aggregate_key: _id,
        }
      end

      def advance_metadata(events)
        self.next_position += events.length
      end

      def state=(new_state)
        @state_changed = true
        super(new_state)
      end

      def save!
        return true unless @state_changed
        raise StaleObjectError unless _id.present?
        update_result = collection.update_one({
          _id: _id,
          lock_version: self.lock_version,
        }.with_indifferent_access, {
          '$set': {
            state: self.state,
            next_position: self.next_position,
          }.compact,
          '$inc': {
            lock_version: 1
          }
        }.with_indifferent_access)
        raise StaleObjectError if update_result.matched_count < 1
        !!(self.lock_version += 1)
      end

      class << self
        def load(key:, **_)
          where(
            _id: key
          ).first_or_create!
        rescue ::Mongo::Error::OperationFailure => e
          raise e unless e.code == 11000
          retry
        end
      end
    end
  end
end
