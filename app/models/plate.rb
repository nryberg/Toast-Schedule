class Plate
  include MongoMapper::Document
  key :title, String

  belongs_to :template
  
  attr_accessible :title

end
