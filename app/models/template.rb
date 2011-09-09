class Template
  include MongoMapper::Document
  key :name, String, :required => true

  belongs_to :club
  many :plates

  def plate_attributes=(plate_attributes)
    plate_attributes.each do |attribute|
      plates.build(attribute)
    end
  end


 
end
