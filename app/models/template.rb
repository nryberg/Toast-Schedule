class Template
  include MongoMapper::Document
  key :name, String, :required => true

  key :role_types, Hash

  has_many :roles

  belongs_to :club

end
