class MembersController < ApplicationController
  
  skip_before_filter :authorize, :only => [:show, :new, :create]

    # GET /members/1/edit
  
  # GET /members
  # GET /members.xml


  def search
    @params = params[:search]
    @members = Member.by_name_or_email(@params)
    ap @members
  end

  def index
    @club = current_club

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end
 
  def edit
    @member = Member.find(params[:id])
    @club_choices = current_club.to_a
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
    @member.primary_club = current_club.id
    @club_choices = current_club.to_a
    # @editing_self = true
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member}
    end
  end
  
  def create
    @member = Member.new(params[:member])
    @relation = Relationship.new(:club => current_club.id, :member => @member.id, :type => "Guest")
    
    unless session[:club_id].nil? then 
      @club = Club.find(session[:club_id])
      @club.members << @member
      @club.save
    end
    
    if session[:member_id].nil? then
      session[:member_id] = @member.id
    end

    respond_to do |format|
      if @member.save
        @relation.save
        # Then move forward to a new club, or add 
        # to a current club.
        if session[:club_id].nil? then 
          format.html { redirect_to(new_club_url, :notice => 'Member was successfully created.') }
        else
          format.html { redirect_to(@club, :notice => 'Member was successfully created.') }
        end
      else
        format.html { render :action => "new" }
      end
    end
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
