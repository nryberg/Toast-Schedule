module TemplatesHelper
  def test_role_link(name)
    
    link_to_function("Test", h("field_text('one')"))

  end

  def add_role_link(name) 
    #link_to_function name,  "$j('.plates').append('= render(:partial => @plate), :object => Plate.new' );" 
    # link_to_function name,  "$j('.plates').append('= render(@plate)' );" 
    #values = "<p><input id='template_plate_attributes_4e7343b1ea395704c70005bc_title' name='template[plate_attributes][4e7343b1ea395704c70005bc][title]'  type='text' value='' /></p>"
    #values = "<p><input type='text' value='fred' /></p>"
#    id = Time.new.to_f.to_s
#    values = "<input id='template_plate_attributes_" + id + "_title' name='template[plate_attributes][" + id + "][title]' size='30' type='text' value=''>"
    #values = "<p><input type='text' value='fred' id='nice' name='nicest'/></p>"
    # values = "<p>whahasfasdf</p>"
#    link_to_function name,  "$j('.plates').append('" + values + "');"
    #  link_to_function name, "$j('.plates').css('border','1px solid #993300');"
      # "page.insert_html :bottom, :plates, :partial => 'plate', :object => Plate.new" 


#      "remove", "var elem = this; $j(elem).parent().remove()"
  end

end
