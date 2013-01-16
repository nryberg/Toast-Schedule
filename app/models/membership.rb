class Membership
  include MongoMapper::Document    
  timestamps!
  belongs_to :club
  belongs_to :member
  key :type, String
  key :guest_at, Time
  key :member_at, Time
  key :officer_at, Time
  key :member_type, Array
    # Types include: Guest, Member, Officer, Alumni
    # Members can have multiple memberships, but they are nominally exclusive - most guests 
    # are not any other role.

  scope :by_type,  lambda { |name| where(:type=> name) } 
  def self.by_name_or_email(search)
    # self.where(:$or => [{:name => #{search}, {:email => #{search}]).all
  end

  def is_guest
    !self.guest_at.nil? 
  end
 
  def is_member
    !self.member_at.nil? 
  end

  def is_officer
    !self.officer_at.nil?
  end
   
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# belongs_to :model
# many :model
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
