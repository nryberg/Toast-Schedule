class MeetingsController < ApplicationController
  # GET /meetings
  # GET /meetings.xml
  def index
    @club = current_club
    @upcoming_meetings = @club.upcoming_meetings
    @past_meetings = @club.past_meetings
    @header_text = @club.name

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meetings }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.xml
  def show
    @meeting = Meeting.find(params[:id])
    @roles = @meeting.roles.sort_by(&:ordinal)
    
    @club = @meeting.club
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.xml
  def new
    
    @club = current_club 
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
    @club = @meeting.club
#     @members = @club.members
    
  end

  # POST /meetings
  # POST /meetings.xml
  def create
    @club = current_club # Club.find(session[:club_id])
    
    @meeting = Meeting.new(params[:meeting])
    @club.meetings << @meeting
    @club.save
    
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to(@meeting, :notice => 'Meeting was successfully created.') }
        format.xml  { render :xml => @meeting, :status => :created, :location => @club}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.xml
  def update
    @meeting = Meeting.find(params[:id])
    @meeting.refactor_roles
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to([@meeting], :notice => 'Meeting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.xml
  def destroy
    meeting = Meeting.find(params[:id])
    @club = meeting.club
    meeting.destroy
    respond_to do |format|
      format.html { redirect_to(meetings_url) }
      format.xml  { head :ok }
    end
  end
  
  def addrole
    @meeting.roles << [0,0]
  end
  
end
