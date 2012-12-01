class Membership
  include MongoMapper::Document    
  belongs_to :club
  belongs_to :member
  key :type, String

    # Types include: Guest, Member, Officer, Administrator, Alumni
    # Members can have multiple memberships, but they are nominally exclusive - most guests 
    # are not any other role.

  scope :by_type,  lambda { |name| where(:type=> name) } 
  def self.by_name_or_email(search)
    # self.where(:$or => [{:name => #{search}, {:email => #{search}]).all
  end
    
# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# validates_presence_of :attribute

# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
# belongs_to :model
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
