class Template
  include MongoMapper::Document
  key :name, String, :required => true

  belongs_to :club
  many :plates

  def plate_attributes=(plate_attributes)
    if plate_attributes.class == Array then
      plate_attributes.each do |attribute|
        plates << attribute
      end
    else
        plate_attributes.each_key do |key|
          if plate_attributes[key][:remove] == "1" then 
            Plate.delete(key)
          else
            Plate.update(key, plate_attributes[key])
          end
        end
    end
   

  end


 
end
