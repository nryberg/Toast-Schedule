class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    @header_text = "TM Schedule Me - Login"  
  end

  def validate
    @user = User.find_by_email(session[:email])
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user.validated_at.nil? 
      session[:email] = params[:email]
      redirect_to validate_url, :notice => "Please validate your e-mail address."
    else
      if user = User.authenticate(params[:email], params[:password])
        if user.auth_token.nil? 
          user.generate_token(:auth_token)
          user.save
        end

        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        
        session[:club_id] = user.first_club
        
        redirect_to user
      else
        redirect_to login_url, :notice => "Incorrect e-mail or password"
      end
    end

  end

  def destroy
     cookies.delete(:auth_token)
     session[:member_id] = nil
     session[:club_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
