class Emailer < ActionMailer::Base
  default :from => "nryberg@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(:to => user.email, 
         :subject => "Welcome to the awesome site!")
  end
        
end
