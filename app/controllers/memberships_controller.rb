class MembershipsController < ApplicationController

  before_filter :check_officer_count, :only => :update

  def index
  
    @club = current_club
    @members = current_club.active_members
    @officers = current_club.officers
    @guests = current_club.guests


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
    @membership.flag_as_guest(params[:membership][:is_guest])
    @membership.flag_as_officer(params[:membership][:is_officer])
    @membership.flag_as_member(params[:membership][:is_member])

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


  def finish_nominating_officer
    ap params

    # This is the old model
    @membership = Membership.where(:member_id => params["Officer"]).first

    # Fetch old membership
    @old_membership = Membership.where(:member_id => params["old_officer"]).first

    # Fetch new membership
    @new_membership = Membership.where(:member_id => params["Officer"]).first

    @old_membership.flag_as_officer(0)
    @new_membership.flag_as_officer(1)

    @old_membership.save
    @new_membership.save
    redirect_to(@membership.member, :notice => 'Member was succesfully promoted to officer.')

  end

  private 

  def check_officer_count
    officer_count = current_club.officers.count
    ap params
    # This wouldn't flag for any reason _BUT_ the fact that the current officer is removing 
    # their own officer role.  In test and dev this doesn't trigger becuase you're not always officer.
    
    # if officer_count <= 1 && current_user.officer_for(current_club) then
    
    if officer_count <= 1 && current_user.officer_for(current_club) then
      @members = current_club.active_members  
      redirect_to(nominate_officer_path, :notice => 'Please select one other member to be an officer.')
    end
      

  end
  

end
