class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if member = Member.authenticate(params[:email], params[:password])
      p "Member found"
      session[:member_id] = member.id
      session[:member_name] = member.name
      params[:id] = member.id
      @member_signed_in = member
      @member = @member_signed_in
      redirect_to @member_signed_in
    else
      redirect_to login_url
    end

  end

  def destroy
     session[:member_id] = nil
     session[:club_id] = nil
     redirect_to root_path, :notice => "Logged out"
  end

end
