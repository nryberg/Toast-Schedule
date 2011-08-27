class Template
  include MongoMapper::Document
  key :name, String, :required => true

  # key :roles, Hash

  has_many :template_roles

  belongs_to :club


end
