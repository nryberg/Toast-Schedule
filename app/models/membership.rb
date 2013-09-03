class Membership
  include MongoMapper::Document    
  timestamps!
  belongs_to :club
  belongs_to :member
  key :type, String
  key :guest_at, Time
  key :member_at, Time
  key :officer_at, Time
 
  def to_s
    s = Array.new
    if self.is_guest  then
      s << 'Guest'
    elsif self.is_member then
      s << 'Member'
    elsif self.is_officer then
      s << 'Officer'
    end
    s.join(", ")
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

  def is_active
    (self.is_guest || self.is_member || self.is_officer)
  end
 
  def flag_as_guest(check_value)
    check_value == "1" ? self.guest_at = Time.new : self.guest_at = nil 
  end

  def flag_as_member(check_value)
    check_value == "1" ? self.member_at = Time.new : self.member_at = nil 
  end
 
  def flag_as_officer(check_value)
    check_value == "1" ? self.officer_at = Time.new : self.officer_at = nil 
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
