module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end
  
end
