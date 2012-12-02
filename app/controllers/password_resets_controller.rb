class PasswordResetsController < ApplicationController

  def create
    member = Member.find_by_email(params[:email])
    member.send_password_reset if member 
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end




  def new
  end
end
