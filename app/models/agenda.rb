class Agenda
#   include MongoMapper::EmbeddedDocument         
  
  include MongoMapper::Document         
  
  key :notes, String
  key :meeting_date, Date
  key :roles, Array
  
  
  def meeting_date_formatted
    meeting_date.strftime '%m/%d/%Y'
  end
  
  def meeting_date_pretty
    if meeting_date.nil? then 
       "(empty date)"
    else
      meeting_date.strftime '%a, %b %e, %Y'
    end
    
  end
  
  
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
   belongs_to :club
   many :roles
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