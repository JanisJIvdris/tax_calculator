class CountryValidator
    EU_COUNTRIES = %w[Spain France Germany Italy Netherlands].freeze
    NON_EU_COUNTRIES = %w[USA China India Japan].freeze
  
    def self.valid_country?(country)
      (EU_COUNTRIES + NON_EU_COUNTRIES).include?(country)
    end
  
    def self.eu_countries
      EU_COUNTRIES
    end
  end
  