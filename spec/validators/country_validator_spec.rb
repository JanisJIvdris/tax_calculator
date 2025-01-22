require 'rspec'
require_relative '../../lib/validators/country_validator'

RSpec.describe CountryValidator do
  describe '.valid_country?' do
    it 'returns true for valid EU countries' do
      expect(CountryValidator.valid_country?('Spain')).to be true
      expect(CountryValidator.valid_country?('France')).to be true
    end

    it 'returns true for valid non-EU countries' do
      expect(CountryValidator.valid_country?('USA')).to be true
      expect(CountryValidator.valid_country?('China')).to be true
    end

    it 'returns false for invalid countries' do
      expect(CountryValidator.valid_country?('InvalidCountry')).to be false
      expect(CountryValidator.valid_country?('Mars')).to be false
    end
  end

  describe '.eu_countries' do
    it 'includes known EU countries' do
      eu_countries = CountryValidator.eu_countries
      expect(eu_countries).to include('Spain', 'France', 'Germany')
    end

    it 'does not include non-EU countries' do
      eu_countries = CountryValidator.eu_countries
      expect(eu_countries).not_to include('USA', 'China', 'India')
    end
  end
end
