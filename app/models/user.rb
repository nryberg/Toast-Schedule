require 'digest/sha2'

class User
  include MongoMapper::Document        
 
  # Demoting the name to something useful but not necessarily unique. 
  key :nick_name, String, :presence => true

  key :email, String, :unique => true, :presence => true
  key :hashed_password, String
  key :salt, String
  
  key :club_ids, Array  # Simple HABTM for clubs <--> users
  
  # TODO - there's some work to do on implementing other authentication details.  For now, keep it simple stupid.
#   key :confirmation_token, String
#   key :remember_token, String
#   key :email_confirmed, Boolean
  
  timestamps!

  validates_presence_of :name
  validate :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  
  validate :password_must_be_present
  
  def clubs
    @clubs = Club.find(self.club_ids)
  end
  
  def new_club
    @club = Club.new
    @club.set_user(self.id)
    return @club
  end
  
  class << self
    def authenticate(email, password)
      if user = find_by_name(email)
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



#   devise :registerable, :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

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
