class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
    @member_signed_in = User.find(session[:user_id])
    @time = Time.new.to_s
    @clubname = "TM Schedule Me"
    
  end

  def about

  end
  
  def pricing
  end
  def register
  end
  def find_club

    unless params[:search].nil?
      @clubs = Club.searchable_text(params[:search]).all
    end
  end

  def newclub
    @user = User.new
  end

end
