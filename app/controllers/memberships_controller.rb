class MembershipsController < ApplicationController

  def new

    @member = Member.find(params[:member_id])
    @membership = Membership.new
    @membership.member = @member
    @membership.club = current_club
    ap @member
  end

  def update
    ap params
    @membership = Membership.find(params[:id])
    @membership.club = current_club
    ap params[:membership]
    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to(current_club, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end 


end
