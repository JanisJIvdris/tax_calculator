require 'rspec'
require_relative '../lib/models/transaction'

RSpec.describe Transaction do
  describe '#validate!' do
    it 'raises an error for an invalid transaction type' do
      expect {
        Transaction.new(type: 'invalid', buyer_country: 'Spain', buyer_type: 'individual')
      }.to raise_error('Invalid transaction type')
    end

    it 'raises an error for an invalid buyer country' do
      expect {
        Transaction.new(type: 'good', buyer_country: 'Atlantis', buyer_type: 'individual')
      }.to raise_error('Invalid buyer country')
    end

    it 'raises an error for an invalid buyer type' do
      expect {
        Transaction.new(type: 'good', buyer_country: 'Spain', buyer_type: 'alien')
      }.to raise_error('Invalid buyer type')
    end

    it 'raises an error for missing service location on onsite services' do
        expect {
          Transaction.new(type: 'service', buyer_country: 'Spain', buyer_type: 'individual')
        }.to raise_error('Missing service location for onsite services')
      end
      

      it 'does not raise an error for missing service location on digital services' do
        expect {
          Transaction.new(type: 'service', buyer_country: 'Spain', buyer_type: 'individual', service_location: nil)
        }.not_to raise_error
      end
  end
end
