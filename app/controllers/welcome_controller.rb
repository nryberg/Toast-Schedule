class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
    @member_signed_in = Member.find(session[:member_id])
    @time = Time.new.to_s
    @clubname = "TM Schedule Me"
    
  end

  def about

  end
  
  def pricing
  end
  def register
  end
  def newmember
  end

  def newclub
  end

end
