require 'rspec'
require_relative '../../lib/data/vat_rates'

RSpec.describe VATRates do
  describe '.for_country' do
    it 'returns the correct VAT rate for defined EU countries' do
      expect(VATRates.for_country('Spain')).to eq(21)
      expect(VATRates.for_country('France')).to eq(20)
      expect(VATRates.for_country('Germany')).to eq(19)
    end

    it 'raises an error for undefined countries' do
      expect {
        VATRates.for_country('Atlantis')
      }.to raise_error('VAT rate not defined for Atlantis')
    end

    it 'returns 0 VAT for non-EU countries by default' do
      expect {
        VATRates.for_country('USA')
      }.to raise_error('VAT rate not defined for USA')
    end
  end
end
