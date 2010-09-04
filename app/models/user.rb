require 'digest/sha1'

class User
  include MongoMapper::Document        
  
  attr_protected :id, :salt
  attr_accessor :password, :password_confirmation

  key :email, String
  key :encrypted_password, String
  key :salt, String
  key :confirmation_token, String
  key :remember_token, String
  key :firstname, String
  key :email_confirmed, Boolean
  key :lastname, String
  timestamps!
  
  def encrypt(password)
    Digest::SHA1.hexdigest "--#{salt}--#{password}--"
  enda
  
  def password=(pass)
    @password=pass
    self.salt = initialize_salt if !self.salt?
    self.encrypted_password = User.encrypt(@password, self.salt)
  end
  
  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end
  
  protected 
  
  def initialize_salt
    self.salt = Digest::SHA1.hexdigest(
      "--#{Time.now.to_s}--#{email}--") if new_record?
  end
 
  def self.authenticate(login, pass)
  u=find(:first, :conditions=>["email= ?", login])
  return nil if u.nil?
  return u if User.encrypt(pass, u.salt)==u.hashed_password
  nil
end  

    
#  devise :registerable, :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

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