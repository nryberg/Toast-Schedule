class Subscription < ActiveRecord::Base
  include MongoMapper::Document         
  timestamps!

  belongs_to :club
  validates_presence_of :club_id
end
