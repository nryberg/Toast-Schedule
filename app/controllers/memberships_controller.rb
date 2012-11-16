class MembershipsController < ApplicationController
  def edit
    @membership  = Membership.find(params[:id])
    
  end

  def new

    @member = Member.find(params[:member_id])
    @membership = Membership.new
    @membership.member = @member
    @membership.club = current_club
    ap @member
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


end
