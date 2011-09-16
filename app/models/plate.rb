class Plate
  include MongoMapper::Document
  key :title, String
  key :remove, String

  belongs_to :template
  
  attr_accessible :title

end
