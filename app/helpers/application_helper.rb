module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end

  def current_user  
    auth_token = cookies.permanent[:auth_token] || cookies[:auth_token] 
    Member.find({:auth_token => auth_token}) 
  end

  def current_user_is_officer
    user = current_user 
    club = current_club
    user.nil? ? FALSE : user.officer_for(club)

  end



  def current_club
    Club.find(session[:club_id])
  end

  def logged_in
    !session[:member_id].nil?
  end

  def relationship_types
    ["Guest", "Member", "Officer"] 
  end

end
