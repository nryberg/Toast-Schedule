class Meeting
  include MongoMapper::Document         
  validates_presence_of :meeting_date
  after_update :comb_roles

  key :theme, String
  key :meeting_date, Date, :index => true
  
  def comb_roles
    self.roles.each_index do |index|
      self.role[index].ordinal = index
    end

  end

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
