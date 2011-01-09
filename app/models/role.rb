class Role
  include MongoMapper::Document
  
#   key :member_id, :typecast => 'ObjectId'
#   key :role_type_id, :typecast => 'ObjectId'
  
  key :member_id
  key :role_type_id 
  key :agenda_id, ObjectId

# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
   belongs_to :agenda
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

class OrderedRole < Role
  attr_accessor :order
end