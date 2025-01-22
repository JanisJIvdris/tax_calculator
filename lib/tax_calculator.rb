require_relative 'data/vat_rates'
require_relative 'models/transaction'

class TaxCalculator
  def self.calculate(transaction)
    case transaction.type
    when 'good'
      calculate_goods_tax(transaction)
    when 'service'
      transaction.digital? ? calculate_digital_service_tax(transaction) : calculate_onsite_service_tax(transaction)
    else
      raise 'Unsupported transaction type'
    end
  end

  private

  def self.calculate_goods_tax(transaction)
    if transaction.buyer_in_spain?
      { vat: transaction.vat_rate_in_spain }
    elsif transaction.buyer_in_eu?
      transaction.individual_buyer? ? { vat: transaction.local_vat_rate } : { vat: 0, status: 'reverse charge' }
    else
      { vat: 0, status: 'export' }
    end
  end

  def self.calculate_digital_service_tax(transaction)
    if transaction.buyer_in_spain?
      { vat: transaction.vat_rate_in_spain }
    elsif transaction.buyer_in_eu?
      transaction.individual_buyer? ? { vat: transaction.local_vat_rate } : { vat: 0, status: 'reverse charge' }
    else
      { vat: 0 }
    end
  end

  def self.calculate_onsite_service_tax(transaction)
    if transaction.service_in_spain?
      { vat: transaction.vat_rate_in_spain }
    else
      { vat: 0 }
    end
  end
end
