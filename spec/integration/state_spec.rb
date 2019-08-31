module Midnight
  module Mongoid
    module StateTest
      RSpec.describe State do
        it 'should be able to create new object' do
          record = nil
          expect do
            record = described_class.load(key: 'test_aggregate_key')
          end.not_to raise_error
          expect(record.metadata).not_to be_empty
        end

        it 'should be able to persist the state' do
          record = described_class.load(key: 'test_aggregate_key')
          record.state = {
            a: 'a',
          }
          record.save!
          loaded_record = described_class.load(key: 'test_aggregate_key')
          expect(loaded_record.state[:a]).to eq('a')
        end

        it 'should be able to detect concurrent write when save' do
          record_a = described_class.load(key: 'test_aggregate_key')
          record_b = described_class.load(key: 'test_aggregate_key')
          record_a.state = { a: 'a' }
          record_b.state = { b: 'b' }
          expect do
            record_a.save!
          end.not_to raise_error
          expect do
            record_b.save!
          end.to raise_error(Commons::ConcurrentWriteError)
        end

        it 'implements the interface for metadata advancements' do
          record = described_class.load(key: 'test_aggregate_key')
          expect do
            record.advance_metadata([])
          end.not_to raise_error
        end
      end
    end
  end
end
