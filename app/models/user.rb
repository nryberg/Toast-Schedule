
class User
  include MongoMapper::Document        
  

#  key :email, String, :unique => true
  key :email
  key :encrypted_password, String
  key :salt, String
  key :confirmation_token, String
  key :remember_token, String
  key :name, String, :unique => true
  key :email_confirmed, Boolean
 
    
  timestamps!

  validates_presence_of :name
  attr_accessible :name, :email, :password, :password_confirmation
  
  devise :registerable, :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

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