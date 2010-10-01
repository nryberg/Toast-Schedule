class Club
  include MongoMapper::Document         
  
  key :name, String, :required => true
  
  key :user_ids, Array # Other side of HABTM work 
  
  many :members
  
  def users
    @users = User.find(self.user_ids)
  end
  
  def set_user(user_id)
    self.user_ids << user_id
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
