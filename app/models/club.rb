class Club
  include MongoMapper::Document         
  timestamps!

  key :name, String, :required => true
  key :address, String
  key :club_number, String
  key :time_zone, String
  key :plan_initial, Date
  key :plan_renewal, Date
  key :plan_type, String
  key :billing_period, String
  
  scope :by_name,  lambda { |name| where(:name => name) } 
  
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  many :meetings
  many :memberships
  many :billings


  def next_renewal_date
    period = case self.billing_period
      when "Monthly" then 1
      when "Six Months" then 6
      when "Annual" then 12
      when nil then 0
    end
    start = self.plan_renewal || DateTime.now
    out = (start >> period).strftime("%m/%d/%Y")


  end

  def upcoming_meetings
    self.meetings.where(:meeting_date => {'$gt' => 2.day.ago.midnight}).sort(:meeting_date).all
  end

  def past_meetings
    self.meetings.where(:meeting_date => {'$lt' => 2.day.ago.midnight}).sort(:meeting_date.desc).all
  end

  def has_upcoming_meetings
    self.meetings.upcoming > 0
  end
  
  def has_past_meetings
    self.meetings.past > 0
  end

  def all_members
    members = self.memberships.all.map{|x| x.member}
  end

  def all_memberships
    memberships = self.memberships.all.map{|x| x.member}
    memberships.uniq.sort_by {|x| x.name}
  end

  def active_members
    self.memberships.where(:member_at => {'$ne' => nil}).all.map {|x| x.member}
  end
  def officers
    self.memberships.where(:officer_at => {'$ne' => nil}).all.map {|x| x.member}
  end
  
  def guests
    self.memberships.where(:guest_at => {'$ne' => nil}).all.map {|x| x.member}
  end

# TODO: Refactor in the membership management 

 
  def self.searchable_text(search)
    self.where(:$or => [{:name => /#{search}/}, {:club_number => /#{search}/}, {:address => /#{search}/}])
  end
# one :model

# Callbacks ::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
# before_create :your_model_method
# after_create :your_model_method
# before_update :your_model_method 

# Attribute options extras ::::::::::::::::::::::::::::::::::::::::
# attr_accessible :first_name, :last_name, :email

# Validations
# key :name, :required =>  true      

# Defaults
# key :done, :default => false

# Typecast
# key :user_ids, Array, :typecast => 'ObjectId'
  
   
end
