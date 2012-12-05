class MembersController < ApplicationController
  
  skip_before_filter :authorize, :only => [:show, :new, :create]

    # GET /members/1/edit
  
  # GET /members
  # GET /members.xml


  def index
    @club = current_club

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
    ap params
    
  end

 
  def edit
    @member = Member.find(params[:id])
    #@club_choices = @member.clubs
    @editing_self = (params[:id] == session[:member_id].to_s)
    
  end

  def show
    @member = Member.find(params[:id])
    @roles = Role.where(:member_id => params[:id]).sort(:meeting_date.desc).all
     

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

    #ap params

    @member = Member.find_by_email(params[:member][:email])

    if @member.nil? then  # they're not in the club

    else
      @membership_test =  Membership.find_by_member_id_and_club_id(@member.id, current_club.id) 

      if !@membership_test.nil? then
        redirect_to(edit_membership_url(@membership_test), :notice => 'Person is already a part of this club')
      elsif !@member.nil? then
        
        redirect_to(edit_member_url(@member), :notice => 'Person is in scheduler, but not this club')
      end
    else
      @member = Member.new
      @member.name = params[:member][:name]
      @member.email = params[:member][:email]
      
      
      
      unless session[:club_id].nil? then 
        @membership = Membership.new(:club => current_club, :member => @member, :type => params[:member][:type])
      end
      
      if session[:member_id].nil? then
        session[:member_id] = @member.id
      end

      respond_to do |format|
        if @member.save
          unless @membership.nil? then @membership.save end
          format.html { redirect_to(current_club,  :notice => 'Member was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end #if !membership already existed
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
