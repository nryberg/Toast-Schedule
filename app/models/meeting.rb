class Meeting
  include MongoMapper::Document         
  validates_presence_of :meeting_date

  key :theme, String
  key :meeting_date, Date, :index => true

  scope :upcoming, lambda {where :meeting_date.gt => Time.now}
  def meeting_date_formatted
      if meeting_date.nil? then 
         ''
      else
         meeting_date.strftime '%m/%d/%Y' 
      end
    
  end
  
  def meeting_date_pretty
    if meeting_date.nil? then 
       "(empty date)"
    else
      meeting_date.strftime '%A, %b %e, %Y'
    end
    
  end

  def meeting_date_short
    if meeting_date.nil? then 
       "(empty date)"
    else
      meeting_date.strftime '%m/%e/%y'
    end
    
  end
  
  def member_roles(member_id)
    
  end

  def last_role
    roles = self.roles.sort_by(&ordinal)
  end
# validates_presence_of :attribute
  many :roles, :dependent => :destroy

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
