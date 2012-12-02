module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end

  def current_user
    Member.find({:auth_token => cookies[:auth_token]}) 
    #Member.find(session[:member_id])
  end

  def current_club
    m = Member.find({:auth_token => cookies[:auth_token]}) 
    if session[:club_id].nil? then
      session[:club_id] = m.my_club("id")
    end 
    #Club.find(session[:club_id])
    m.my_club
  end

  def logged_in
    !session[:member_id].nil?
  end

  def relationship_types
    ["Guest", "Visitor", "Member", "Officer", "Alumni", "Administrator"]
  end

end
