class VATRates
    EU_VAT_RATES = {
      'Spain' => 21,
      'France' => 20,
      'Germany' => 19,
      # Add other EU countries...
    }
  
    NON_EU_VAT = 0
  
    def self.for_country(country)
      EU_VAT_RATES[country] || raise("VAT rate not defined for #{country}")
    end
  end
  