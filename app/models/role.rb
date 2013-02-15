class Role
  include MongoMapper::Document
#   key :member_id, :typecast => 'ObjectId'
#   key :role_type_id, :typecast => 'ObjectId'
  timestamps!

  scope :prior, lambda {|_meeting_id, _ordinal| where(:meeting_id => _meeting_id, :ordinal.lt => _ordinal)}
  scope :next, lambda {|_meeting_id, _ordinal| where(:meeting_id => _meeting_id, :ordinal.gt => _ordinal)}
  scope :by_meeting_id, lambda {|_meeting_id| where(:meeting_id => _meeting_id)}
  scope :mine, lambda {|_member_id| where(:member_id => _member_id)}
 # scope :past, lambda {where("meeting.meeting_date < ?", Date.new)}

  scope :upcoming, lambda {where(:date_meeting.gt => Time.new)}
  
  
  key :member_id, ObjectId
  key :role_type_id, ObjectId 
  key :title, String
  key :ordinal, Integer

  validates_presence_of :member_id
  validates_presence_of :ordinal

  def is_first
    self.ordinal == 0
  end

  def is_last
    self.ordinal == self.meeting.roles.count
  end

  def meeting_index
    self.meeting.roles.index(self)
  end

  def move_up
    unless self.is_first
#     meet = self.meeting
#     my_index = self.meeting_index 
#     swapped = meet.roles[my_index - 1]
#     meet.roles[my_index] = swapped
#     meet.roles[my_index - 1] = self
#     meet.save
      _prior = Role.prior(self.meeting_id, self.ordinal).sort(:ordinal.desc).first
      _prior.ordinal += 1
      self.ordinal -= 1
      _prior.save
      self.save

    end
    self.meeting.refactor_roles
  end

  def move_down
    _next = Role.next(self.meeting_id, self.ordinal).sort(:ordinal).first
    unless _next.nil?
      _next.ordinal -= 1
      self.ordinal += 1
      _next.save
      self.save
    end
    self.meeting.refactor_roles
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
