require 'digest/sha2'
class User
  include MongoMapper::Document
  before_create { generate_token(:auth_token) }  
  timestamps!

  key :name, String
  
  key :email, String
  key :can_edit, Boolean  # Can Edit if they are an officer.  The first user is Secretary by default
  key :active, Date

  key :auth_token, String
  key :password_reset_token, String 
  key :password_reset_sent_at, Time
  key :validation_token, String 
  key :validation_sent_at, Time
  key :validated_at, Time

  #Password 
  key :salt, String
  key :hashed_password, String
  
  scope :by_name,  lambda { |name| where(:name => name) } 

  validate :password, :confirmation => true  
  attr_accessor :password_confirmation  
  attr_reader :password  

  many :clubs

  def has_upcoming_roles
    Role.where(:member_id => self.id, :date_meeting.gte => Time.new).count
          
  end
  def last_five_roles
          
    self.roles.sort_by{|e| e.date_meeting }
  end
 
  def my_role_types(club_id)
    related = Membership.where(:member_id => self.id, :club_id => club_id).all
    types = related.collect {|x| x.type}
  end

  def officer_for(club)
    mos = self.memberships.select {|x| x.is_officer && x.club == club}
    mos.count > 0
  end

  def active_memberships
    self.memberships.select {|x| x.is_active}
  end 

  def has_membership(in_club_id)
    Membership.where(:club_id => in_club_id, :member => self.id).first
  end
    

  def my_club
    Club.find(self.primary_club.to_s)
  end

  def roles
    rolez = Role.mine(id).all
    rolez.sort_by {|e| e.meeting.meeting_date || 0}
  end

  def upcoming_roles
    
    self.roles.delete_if{|e| e.date_meeting <= Time.new}
  end

  def past_roles
    rolez = Role.mine(id).all
    rolez.delete_if {|e| e.meeting.meeting_date.nil?}
    rolez.sort_by {|e| e.meeting.meeting_date || 0}
    rolez.delete_if {|e| e.meeting.meeting_date > Time.new}
  end

  def self.by_name_or_email(search)
    self.where(:$or => [{:name => /#{search}/}, {:email=> /#{search}/}])
  end
 
 
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Member.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    MemberMailer.password_reset(self).deliver
  end

  def guest
    !self.guest_at.nil?
  end

  def send_validation_email
    self.generate_token(:validation_token)
    self.validation_sent_at = Time.zone.now
    save!
    MemberMailer.welcome_confirm_new_user(self).deliver
  end

  def self.new_guest
    new { |u| u.guest_at = Time.zone.now}
  end
#   Pulling out the required password.  
#   HOWEVER: If the user doesn't have an e-mail 
#   and password defined, then they will not be able to 
#   either edit the club, details OR enter their 
#   availability (when that gets implemented.
#   validate :password_must_be_present  
  
  
 
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute
 
# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
    #    :club
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
  class << self
    def authenticate(email, password)  
      p email
      p password
      if user = find_by_email(email) 
        p "user found"
        if user.hashed_password == encrypt_password(password, user.salt)  
          user  
        end  
      end  
    end  
  
    def encrypt_password(password, salt)  
      Digest::SHA2.hexdigest(password + "washer" + salt)  
    end  
  end  
  
  def password=(password)  
    @password = password  
    if password.present?  
      generate_salt  
      self.hashed_password = self.class.encrypt_password(password, salt)  
    end  
  end  
  
   
  private  
    def password_must_be_present  
      errors.add(:password, "Missing password" ) unless hashed_password.present?  
    end  
      
    def generate_salt  
      self.salt = self.object_id.to_s + rand.to_s  
    end  

end
