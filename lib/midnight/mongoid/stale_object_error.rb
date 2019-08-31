require 'midnight/business_logic'

module Midnight
  module Mongoid
    class StaleObjectError < StandardError
      include ::Midnight::Mongoid::Error
      include Commons::ConcurrentWriteError
    end
  end
end
