class Role
  include MongoMapper::Document
#   key :member_id, :typecast => 'ObjectId'
#   key :role_type_id, :typecast => 'ObjectId'
  
  key :member_id, ObjectId
  key :role_type_id, ObjectId 
  key :title, String
  key :ordinal, Integer
  key :up_sibling, ObjectId
  key :down_sibling, ObjectId

  validates_presence_of :member_id

  def move_up
    unless self.up_sibling.nil?
      prior = Role.find(self.up_sibling)
      self.ordinal = prior.ordinal
      prior.ordinal += 1
      prior.save
    end
  end

  def move_down
    unless self.down_sibling.nil?
      post = Role.find(self.down_sibling)
      self.ordinal = post.ordinal
      post.ordinal -= 1
      post.save
    end
  end

  def date_meeting
    self.meeting.meeting_date
  end
  
  def member_name
    Member.find(self.member_id).name
  end
  
  def role_type
    RoleType.find(self.role_type_id).name
  end
  
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
   belongs_to :meeting
  belongs_to :template   
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
