require 'digest/sha2'

class Member
  include MongoMapper::Document         
  key :name, String
  
  key :club_id, ObjectId
  key :email, String
  key :phone, String
  key :can_edit, Boolean
  key :role, String
  key :salt, String
  key :hashed_password, String
 
  validates_presence_of :name
  validate :password, :confirmation => true  
  attr_accessor :password_confirmation  
  attr_reader :password  
    
  validate :password_must_be_present  
  
 
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute
 
# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  belongs_to :club
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
   
end                                                 