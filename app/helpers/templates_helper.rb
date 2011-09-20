module TemplatesHelper
  def add_role_link(name) 
    #link_to_function name,  "$j('.plates').append('= render(:partial => @plate), :object => Plate.new' );" 
    link_to_function name,  "$j('.plates').append('!= render(@plate)' );" 

    #  link_to_function name, "$j('.plates').css('border','1px solid #993300');"
      # "page.insert_html :bottom, :plates, :partial => 'plate', :object => Plate.new" 


#      "remove", "var elem = this; $j(elem).parent().remove()"
  end

end
