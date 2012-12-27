class Emailer < ActionMailer::Base
  default :from => "info@tmschedule.me"
  
  def welcome_email(user)
    @user = user
    @url = "http://www.tmschedule.me"
    mail(:to => user.email, 
         :subject => "Welcome to the awesome site!")
  end
        
end
