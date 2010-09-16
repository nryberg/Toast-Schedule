class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
    @time = Time.new.to_s
    
  end
  
end
