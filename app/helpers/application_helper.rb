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
    current_user.my_club

    # TODO: Cleaned out the garbage, but we're still going to have issues with users admin'ing multiple clubs.
    #       Hardly seems worth another call - why not just go for the gusto.
    #       Where does the guest go?
    #       What's the public view???  
    #       Can a club be "publicly" published?  What shouldn't appear?  Probably not the personal stuff.
  end

  def logged_in
    !session[:member_id].nil?
  end

  def relationship_types
    ["Guest", "Visitor", "Member", "Officer", "Alumni", "Administrator"]
  end

end
