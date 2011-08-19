class Template
  include MongoMapper::Document
  key :name, String, :required => true

  key :roles, Hash

  has_many :roles

  belongs_to :club

  def role_attributes=(role_attributes)
    role_attributes.each do |attributes|
      roles.build(attributes)
    end
  end

end
