module Midnight
  module MongoidTest
    RSpec.describe Mongoid do
      it 'has a version number' do
        expect(Mongoid::VERSION).not_to be nil
      end
    end
  end
end
