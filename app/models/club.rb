class Club
  include MongoMapper::Document         
  
  key :name, String, :required => true
  key :address, String
  key :club_number, String
  
  key :member_ids, Array
  many :members, :in => :member_ids
  
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
  many :meetings
  many :relationships

  def relationships
    Relationship.where(:club => self.id).all
  end

  def upcoming_meetings
    self.meetings.where(:meeting_date => {'$gt' => 2.day.ago.midnight}).sort(:meeting_date).all
  end

  def members_active
    self.members.all(:active => true).sort! { |a,b| a.name <=> b.name }
  end
  def members_in_active
    memb = self.members.all(:active => false)
    memb << self.members.all(:active => nil)
    memb.sort! { |a,b| a.name <=> b.name }
  end
 
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
