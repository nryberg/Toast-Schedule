class MembersController < ApplicationController
  
  skip_before_filter :authorize, :only => [:show, :new, :create]

    # GET /members/1/edit
  
  # GET /members
  # GET /members.xml

  def validate_me
    @member = Member.find(params[:id])
    @member.send_validation_email
    respond_to do |format|
      format.html
    end
  end

  def validate
    @member = Member.find_by_validation_token(params[:id])
    @member.validated_at =  Time.zone.now
    cookies[:auth_token] = @member.auth_token
    respond_to do |format|
      if @member.save 
        format.html # index.html.erb
      end
    end

  end

  def index
    #@club = Club.find(current_club
    @club = Club.find(session[:club_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  def edit
    @member = Member.find(params[:id])
    #@club_choices = @member.clubs
    @editing_self = (params[:id] == session[:member_id].to_s)
    
  end

  def show
    @member = Member.find(params[:id])
    @roles = Role.where(:member_id => params[:id]).sort(:meeting_date.desc).all

    @memberships = @member.active_memberships.sort_by {|m| m.club.name}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end
  end
 
  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new
    @member.email = @search_string ||= ""
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member}
    end
  end
  
  def create
    # If they do exist, but aren't in the club, add the membership
    # If they do exist and have a membership, go to edit the membership.
    # At the end of the day, the result is the same.  
    #   1) Pull a member, build if it doesn't exist
    #   2) Pull the membership, build if it doesn't exist
    #   3) Move to the membership edit

    message = "(Blank)"
    email = params[:member][:email]
    @member = Member.find_by_email(email) || Member.new(params[:member])
   
    @membership =  Membership.find_by_member_id_and_club_id(@member.id, current_club.id) 

    if @membership.nil? then # they don't yet have a membership
      @membership = Membership.new(:club => current_club, :member => @member, :type => 'Guest')
    end
    @membership.member_at = Time.new
    @membership.save
      
    respond_to do |format|
        if @member.save 
          format.html { redirect_to(@member,  :notice => 'Member was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    #end #if !membership already existed
  end
  
   # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])


    respond_to do |format|
      if @member.update_attributes(params[:member])
        Emailer.welcome_email(@member).deliver
        format.html { redirect_to(@member, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end
  
    # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    
    
    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
  

end
