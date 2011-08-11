class Template
  include MongoMapper::Document
  key :name, String, :required => true

  key :roles, Hash

end
