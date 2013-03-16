class ClubMailer < ActionMailer::Base
  default from: "tmschedule@rybergs.com"

  def welcome_new_club(club, member)
    @club = club

    @club_url = "/club/#{@club.id}"

    mail :subject => "Welcome to your new club on TM Schedule!", :to => member.email

  end
end
