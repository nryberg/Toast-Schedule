class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :administrator
 
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


  def current_club
    if session[:club_id] then
      Club.find(session[:club_id])
    else
      Club.find(current_user.primary_club)
    end
  end
  helper_method :current_club

  def current_user

    @current_user ||= Member.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

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
      if Member.find_by_auth_token(cookies[:auth_token])
        @member_signed_in = Member.find_by_auth_token(cookies[:auth_token])
      else
        redirect_to login_url, :notice => "Please log in"
      end
    end

    def administrator
      unless current_user.nil? or current_club.nil? then
        if current_user.admin_for(current_club)
        else
          # redirect_to :action => "display"
        end
      end
      
    end
    

end
