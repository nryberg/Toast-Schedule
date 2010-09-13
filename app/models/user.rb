require 'digest/sha2'

class User
  include MongoMapper::Document        
  

#  key :email, String, :unique => true
  key :email
  key :hashed_password, String
  key :salt, String
  key :confirmation_token, String
  key :remember_token, String
  key :name, String, :unique => true, :presence => true
  key :email_confirmed, Boolean
 
    
  timestamps!

  validates_presence_of :name
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  
  valid :password_must_be_present
  
    class << self
      def authenticate(name, password)
	if user = find_by_name(name)
	  if user.hashed_password == encrypt_password(password, user.salt)
	    user
	  end
	end
      end

      def encrypt_password(password, salt)
	Digest::SHA2.hexdigest(password + "wibble" + salt)
      end
    end
  
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
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