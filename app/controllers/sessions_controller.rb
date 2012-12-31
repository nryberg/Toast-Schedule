class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    @header_text = "TM Schedule Me - Login"  
  end

  def create
    if member = Member.authenticate(params[:email], params[:password])
      if member.auth_token.nil? 
        member.generate_token(:auth_token)
        member.save
      end

      if params[:remember_me]
        cookies.permanent[:auth_token] = member.auth_token
      else
        cookies[:auth_token] = member.auth_token
      end
      
      session[:club_id] = member.primary_club
      
      redirect_to member
    else
      redirect_to login_url, :notice => "Incorrect e-mail or password"
    end

  end

  def destroy
     cookies.delete(:auth_token)
     session[:member_id] = nil
     session[:club_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
