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

  #TODO: do a better job on moving the relationship to the Relationship model

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

  def membership_by_type(type = "")
    #TODO Fix the member search by type so we can exclude better

    if type == "" then 
      @mbrs = self.memberships.where(:type => 'Member').all
    else

      @mbrs = self.memberships.where(:type => type).all
    end

    out = @mbrs.map {|x| x.member}
    out.sort_by {|x| x.name} 
  end
  def active_members
    self.membership_by_type('Member')
  end
  
  def officers
    memberships = self.memberships.where(:type => 'Officer').all
  end
  
  def guests
    x = self.memberships.find_all_by_type('Guest')
    ap x
  end

# TODO: Refactor in the membership management 

#  def members
#    _members = Relationship.by_club(self.id).members.officers.sort(:name).all.map { |x| x.member_object}
#    _members.uniq!
#    _members.sort_by(&:name)
#  end
#  def members_in_active
#    memb = self.members.all(:active => false)
#    memb << self.members.all(:active => nil)
#    memb.sort! { |a,b| a.name <=> b.name }
#  end
 
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
