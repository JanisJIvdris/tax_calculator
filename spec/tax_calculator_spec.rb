require 'rspec'
require 'tax_calculator'
require 'models/transaction'

RSpec.describe TaxCalculator do
  context 'when transaction is a good' do
    it 'applies Spanish VAT for buyers in Spain' do
      transaction = Transaction.new(type: 'good', buyer_country: 'Spain', buyer_type: 'individual')
      result = TaxCalculator.calculate(transaction)
      expect(result[:vat]).to eq(21)
    end

    it 'applies local VAT for individual buyers in EU countries' do
      transaction = Transaction.new(type: 'good', buyer_country: 'France', buyer_type: 'individual')
      result = TaxCalculator.calculate(transaction)
      expect(result[:vat]).to eq(20)
    end
  end

end
