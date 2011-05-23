class Meeting
#   include MongoMapper::EmbeddedDocument         
  
  include MongoMapper::Document         
  key :theme, String
  key :meeting_date, Date, :index => true
  
  validates_presence_of :meeting_date

  def meeting_date_formatted
    meeting_date.strftime '%m/%d/%Y'
  end
  
  def meeting_date_pretty
    if meeting_date.nil? then 
       "(empty date)"
    else
      meeting_date.strftime '%A, %b %e, %Y'
    end
    
  end
  
  def member_roles(member_id)
    
  end
# validates_presence_of :attribute
  has_many :roles, :dependent => :destroy

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
   belongs_to :club

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