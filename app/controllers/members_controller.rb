class MembersController < ApplicationController
  
  skip_before_filter :authorize, :only => [:show, :new, :create]
    # GET /members/1/edit
  
  # GET /members
  # GET /members.xml
  def index
    @club = Club.find(session[:club_id])
    if @club then
       @members = @club.members
    else
      @members = Member.find(session[:member_id])
    end
                           

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end
 
  def edit
    @member = Member.find(params[:id])
    
  end

  def show
    @member = Member.find(params[:id])
    @clubs = @member.clubs
    @clubs.each do |club|
      p club.name
    end
  
#     @club = Club.find(params[:club_id])

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
    @member = Member.new(params[:member])
    
    # TODO Get the Rails Idiom correct.
    if session[:club_id] then 
      @member.club_ids << session[:club_id]
      Club.find(session[:club_id]).member_ids << @member
      p "hello"
    end
    
    if session[:member_id].nil? then session[:member_id] = @member.id end

    respond_to do |format|
      if @member.save
        session[:member_id] = @member.id
        # Then move forward to a new club, or add 
        # to a current club.
        if session[:club_id].nil? then 
          format.html { redirect_to(new_club_url, :notice => 'Member was successfully created.') }
        else
          format.html { redirect_to(:action => 'index', :notice => 'Member was successfully created.') }
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
