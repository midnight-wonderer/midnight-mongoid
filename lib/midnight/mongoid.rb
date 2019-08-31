require 'active_support/dependencies/autoload'
require_relative 'mongoid/version'

module Midnight
  module Mongoid
    module Error
    end

    extend ::ActiveSupport::Autoload

    autoload :Interactor
    autoload :StaleObjectError
    autoload :State
  end
end
