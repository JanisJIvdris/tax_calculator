require_relative '../validators/country_validator'

class Transaction
  attr_reader :type, :buyer_country, :buyer_type, :service_location


  def initialize(type:, buyer_country:, buyer_type:, service_location: :unspecified)
    @type             = type
    @buyer_country    = buyer_country
    @buyer_type       = buyer_type
    @service_location = service_location
    validate!
  end

 
  def buyer_in_spain?
    buyer_country == 'Spain'
  end


  def buyer_in_eu?
    CountryValidator.eu_countries.include?(buyer_country) && !buyer_in_spain?
  end


  def individual_buyer?
    buyer_type == 'individual'
  end

 
  def digital?
    type == 'service' && service_location.nil?
  end

  
  def service_in_spain?
    service_location == 'Spain'
  end


  def vat_rate_in_spain
    VATRates.for_country('Spain')
  end

 
  def local_vat_rate
    VATRates.for_country(buyer_country)
  end

  private

  def validate!
    raise 'Invalid transaction type'  unless %w[good service].include?(type)
    raise 'Invalid buyer country'     unless CountryValidator.valid_country?(buyer_country)
    raise 'Invalid buyer type'        unless %w[individual company].include?(buyer_type)


    if type == 'service'

      if service_location == :unspecified
        raise 'Missing service location for onsite services'
      end
    end
  end
end
