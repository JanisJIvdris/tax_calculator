require_relative './lib/tax_calculator'
require_relative './lib/models/transaction'

puts "=== Tax Calculator Demonstration ==="

# Example 1: Physical goods sold in Spain to an individual
transaction1 = Transaction.new(type: 'good', buyer_country: 'Spain', buyer_type: 'individual')
puts "Example 1: #{TaxCalculator.calculate(transaction1)}"
# => {:vat=>21}

# Example 2: Digital service sold to a company in France
# Explicitly pass nil to indicate "digital" (no location)
transaction2 = Transaction.new(type: 'service', buyer_country: 'France', buyer_type: 'company', service_location: nil)
puts "Example 2: #{TaxCalculator.calculate(transaction2)}"
# => {:vat=>0, :status=>"reverse charge"} (assuming the logic for EU company digital services)

# Example 3: Digital service sold to an individual in Germany
# Again, pass nil for digital
transaction3 = Transaction.new(type: 'service', buyer_country: 'Germany', buyer_type: 'individual', service_location: nil)
puts "Example 3: #{TaxCalculator.calculate(transaction3)}"
# => {:vat=>19}

# Example 4: Onsite service provided in Spain to an individual from the USA
# Provide an actual location to indicate "onsite"
transaction4 = Transaction.new(type: 'service', buyer_country: 'USA', buyer_type: 'individual', service_location: 'Spain')
puts "Example 4: #{TaxCalculator.calculate(transaction4)}"
# => {:vat=>21}

# Example 5: Physical goods exported to a non-EU country (USA)
transaction5 = Transaction.new(type: 'good', buyer_country: 'USA', buyer_type: 'individual')
puts "Example 5: #{TaxCalculator.calculate(transaction5)}"
# => {:vat=>0, :status=>"export"}

puts "===================================="
