class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if member = Member.authenticate(params[:email], params[:password])
      p "Member found"
      session[:member_id] = member.id
      params[:id] = member.id
      redirect_to clubs_url 
    else
      redirect_to login_url
    end

  end

  def destroy
     session[:member_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
