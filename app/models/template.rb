class Template
  include MongoMapper::Document
  key :name, String, :required => true

  key :role_types, Hash

  has_many :role_types

  belongs_to :club

end
