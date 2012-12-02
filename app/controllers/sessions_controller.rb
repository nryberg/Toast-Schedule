class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    @header_text = "TM Schedule Me - Login"  
  end

  def create
    if member = Member.authenticate(params[:email], params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = member.auth_token
      else
        cookies[:auth_token] = member.auth_token
      end

      #TODO pull out the session stuff and replace with cookie
      session[:member_id] = member.id
      session[:member_name] = member.name
      params[:id] = member.id
      @member_signed_in = member
      @member = @member_signed_in
      redirect_to @member_signed_in
    else
      redirect_to login_url
    end

  end

  def destroy
     cookies.delete(:auth_token)
     session[:member_id] = nil
     session[:club_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
