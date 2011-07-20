class ApplicationController < ActionController::Base
#  before_filter :authorize
# TODO - put the authentication back into place
 
  protect_from_forgery
  def login_required
    if session[:member_id]
      return true
    end
    flash[:warning]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to :controller => "user", :action => "login"
    return false 
  end

  def current_user
    Member.find(session[:member_id])
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
      if Member.find_by_id(session[:member_id])
        @member_signed_in = Member.find(session[:member_id]).first
      else
        redirect_to login_url, :notice => "Please log in"
      end
    end

end
