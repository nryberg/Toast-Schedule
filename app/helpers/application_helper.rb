module ApplicationHelper
  def map_to(address)
    to = "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=" +
         address
  end

  def current_user
    Member.find(session[:member_id])
  end

  def current_club
    Club.find(session[:club_id])
  end

end
