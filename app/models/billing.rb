class Billing
  include MongoMapper::Document

  timestamps!

  key :stripe_id, String
  key :deactivated, Date


  belongs_to :club
  belongs_to :member


end
