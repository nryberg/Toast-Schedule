module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end

  def add_plate_link(name)
    link_to_function name, 
      "$j('p').hide()"
  end

  def link_to_add_fields(name, f, association)  
    ap name
    ap f
    ap association
    new_object = f.object.associations(association).klass.new  
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|  
      render(association.to_s.singularize + "_fields", :f => builder)  
    end  
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))  
  end  

end
