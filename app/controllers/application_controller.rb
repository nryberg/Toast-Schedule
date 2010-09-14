class ApplicationController < ActionController::Base
  before_filter :authorize
  helper :all
  protect_from_forgery
  def login_required
    if session[:user]
      return true
    end
    flash[:warning]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to :controller => "user", :action => "login"
    return false 
  end

  def current_user
    session[:user]
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to_url(return_to)
    else
      redirect_to :controller=>'user', :action=>'welcome'
    end
  end

  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
    end

end
