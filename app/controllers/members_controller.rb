class MembersController < ApplicationController
  
  skip_before_filter :authorize, :only => [:show, :new, :create]

    # GET /members/1/edit
  
  # GET /members
  # GET /members.xml


  def index
    #@club = Club.find(current_club
    @club = Club.find(session[:club_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  def search
    @params = params[:search]
    unless params[:search].nil?
      @candidate = Member.by_name_or_email(params[:search]).all
      @existing = current_club.members.sort_by(&:name)
      @members = @candidate - @existing
    end

  end

  def relate
    
  end

 
  def edit
    @member = Member.find(params[:id])
    #@club_choices = @member.clubs
    @editing_self = (params[:id] == session[:member_id].to_s)
    
  end

  def show
    @member = Member.find(params[:id])
    @roles = Role.where(:member_id => params[:id]).sort(:meeting_date.desc).all

    @memberships = @member.memberships.sort_by {|m| m.club.name}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end
  end
 
  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member}
    end
  end
  
  def create

    # TODO : Build out duplication testing for member.  If they already exist, move the user
    #        to a recovery where they can simply assign that person a new role.
    #        This may cause problems with duplicates with similar but different names.
    #         09:59 PM 11/14/2012

    # 11:33 PM 12/04/2012
    # This whole section needs to be cleaned up.  There's a lot of confusion going on here. 

    # Forget worrying about whether or not the new member is on the books.
    # If they don't exist, add them.
    # If they do exist, but aren't in the club, add the membership
    # If they do exist and have a membership, go to edit the membership.
    # At the end of the day, the result is the same.  
    #   1) Pull a member, build if it doesn't exist
    #   2) Pull the membership, build if it doesn't exist
    #   3) Move to the membership edit

    # 08:09 PM 01/12/2013
    # Getting down to brass tacks.  Keep it simple stupid.  Memberships will be in the background - can be guest, member or
    # officer based on the timestamp for each value

    message = "(Blank)"
    email = params[:member][:email]
    @member = Member.find_by_email(email) || Member.new(params[:id])
   
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
