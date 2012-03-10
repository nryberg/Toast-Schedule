class Role
  include MongoMapper::Document
#   key :member_id, :typecast => 'ObjectId'
#   key :role_type_id, :typecast => 'ObjectId'

  scope :prior, lambda {|_meeting_id, _ordinal| where(:meeting_id => _meeting_id, :ordinal.lt => _ordinal)}
  scope :next, lambda {|_meeting_id, _ordinal| where(:meeting_id => _meeting_id, :ordinal.gt => _ordinal)}
  scope :by_meeting_id, lambda {|_meeting_id| where(:meeting_id => _meeting_id)}
  scope :mine, lambda {|_member_id| where(:member_id => _member_id)}
  
  key :member_id, ObjectId
  key :role_type_id, ObjectId 
  key :title, String
  key :ordinal, Integer

  validates_presence_of :member_id
  validates_presence_of :ordinal

  def move_up
    _prior = Role.prior(self.meeting_id, self.ordinal).sort(:ordinal.desc).first
    unless _prior.nil?
      _prior.ordinal += 1
      self.ordinal -= 1
      _prior.save
      self.save
    end
  end

  def move_down
    _next = Role.next(self.meeting_id, self.ordinal).sort(:ordinal).first
    unless _next.nil?
      _next.ordinal -= 1
      self.ordinal += 1
      _next.save
      self.save
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
