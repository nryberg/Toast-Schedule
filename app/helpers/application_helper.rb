module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end

  def current_user
    Member.find(session[:member_id])
  end

  def current_club
    if session[:club_id].nil? then
      session[:club_id] = current_user.primary_club
    end 
      Club.find(session[:club_id])
  end

  def logged_in
    !session[:member_id].nil?
  end

  def relationship_types
    ["Guest", "Visitor", "Member", "Officer", "Alumni", "Administrator"]
  end

end
