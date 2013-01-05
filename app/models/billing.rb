class Billing
  include MongoMapper::Document

  timestamps!

  key :stripe_id, String
  key :deactivated, Date

  key :amount, Float
  key :transaction_id, String
  key :buyerEmail, String
  key :referenceId, String

  belongs_to :club
  belongs_to :member

  def created_pretty_date
    created_at.strftime("%B %-d, %Y (GMT)")
  end

  def transaction_amount=(currency_and_amount)
    currency = parse(currency_and_amount).first
    if currency == 'USD'
      amount = parse(currency_and_amount).last.to_f
    else
      amount = currency.to_f
    end
    self.amount = amount unless amount == 0.0
  end

  def parse(currency_and_amount)
    @parsed ||= currency_and_amount.split
  end
end
