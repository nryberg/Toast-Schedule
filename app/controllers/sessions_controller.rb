class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      params[:id] = user.id
      redirect_to clubs_url 
    else
      redirect_to login_url
    end

  end

  def destroy
     session[:user_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
