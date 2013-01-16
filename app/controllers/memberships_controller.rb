class MembershipsController < ApplicationController

  def index

    # TODO: DRY this out.  Honestly.  
    # 04:51 PM 12/05/2012
    # Maybe just fetch the different types (excluding admin/officer) 
    # and walk through the array.
  
    # TODO: Implement some sort of scoping for roles
    # Role   -  View
    # Guests - active members and no e-mail
    # Active - Active members and no e-mail (?)
    # Officers - All
    # Admin - All, however only admin can change anything - need trap for losing your last admin
    # Alumni - Active members, each other (?)
    # 


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
    ap params
    @membership = Membership.find(params[:id])
    @membership.type = params[:membership][:type]
    respond_to do |format|
      if @membership.save
        format.html { redirect_to(current_club, :notice => 'Member was successfully updated.') }
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
