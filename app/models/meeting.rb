class Meeting
  include MongoMapper::Document         
#  validates_presence_of :meeting_date

  timestamps!
  key :theme, String
  key :meeting_date, Time

  scope :upcoming, lambda {where :meeting_date.gt => Time.now}
  scope :past, lambda {where :meeting_date.lt => Time.now}

  attr_accessor :meeting_time_part
  attr_accessor :meeting_date_part

  before_update :set_time_stamp

  def meeting_date_part
      if meeting_date.nil? then 
        Time.now.strftime '%m/%d/%Y' 
      else
         meeting_date.strftime '%m/%d/%Y' 
      end
   
  end


  def meeting_date_formatted
      if meeting_date.nil? then 
         ''
      else
         meeting_date.strftime '%m/%d/%Y' 
      end
    
  end

  def meeting_time_part
    
      if meeting_date.nil? then 
        Time.now.strftime '%I:%M %p'
      else
         meeting_date.strftime '%I:%M %p'
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
  
  def refactor_roles
    counter = 0
    roles = self.roles.all(:order => :ordinal)
    roles.each do |role|
      role.ordinal = counter
      role.save
      counter += 1
    end
  
  end
  
  def member_roles(member_id)
    
  end
  
  def role_first 
    role = self.roles.first(:order => :ordinal)
  end

  def role_last
    role = self.roles.last(:order => :ordinal)
  end
# validates_presence_of :attribute
  many :roles, :dependent => :destroy do
    def mine(id)
      where(:member_id => id)
    end
  end

  def role_promote(a_role)
    roles = self.roles.all(:order => :ordinal)
    roles.each do |a_role| 

    end 


  end
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
  

  private
  def set_time_stamp
    if not @meeting_time_part.nil? then
      self.meeting_date = DateTime::strptime(@meeting_date_part + " " + @meeting_time_part ,"%m\/%d\/%Y %I:%M %p") 
    end
  end
end
