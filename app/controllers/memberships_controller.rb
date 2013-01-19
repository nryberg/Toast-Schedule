class MembershipsController < ApplicationController

  def index
  
    # TODO: Implement some sort of scoping for roles
    # Role   -  View
    # Guests - active members and no e-mail
    # Member - Active members and no e-mail (?)
    # Officers - All
    
    @club = current_club
    @members = current_club.active_members
    @officers = current_club.membership_by_type('Officer')
    @guests = current_club.membership_by_type('Guest')
    @alumni = current_club.membership_by_type('Alumni')
    @admins = current_club.membership_by_type('Admin')


  end
  def edit
    @membership  = Membership.find(params[:id])

    
  end

  def new

    @member = Member.find(params[:member_id])
    @membership = Membership.new
    @membership.member = @member
    @membership.club = current_club
  end

  def create
    @membership = Membership.new()
    
    @membership.member = Member.find(params[:membership][:member])
    @membership.club = Club.find(params[:membership][:club])
    @membership.type = params[:membership][:type]

    respond_to do |format|
      if @membership.save
        format.html { redirect_to(current_club, :notice => 'Membership was successfully added.') }
#         format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
#         format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    
    @membership = Membership.find(params[:id])
    @membership.flag_as_guest(params[:membership][:is_guest])
    @membership.flag_as_officer(params[:membership][:is_officer])
    @membership.flag_as_member(params[:membership][:is_member])
    respond_to do |format|
      if @membership.save
        format.html { redirect_to(@membership.member, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end 

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    
    
    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
  

end
