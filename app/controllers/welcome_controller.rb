class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
    @member_signed_in = Member.find(session[:member_id])
    @time = Time.new.to_s
    
  end
  
end
