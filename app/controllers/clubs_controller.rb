class ClubsController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show, :new, :create]
  
  # GET /clubs
  # GET /clubs.xml
  def index
    if session[:member_id] then
       @clubs = Member.find(session[:member_id]).clubs
    else
      @clubs = Club.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @club = Club.find(params[:id])
    session[:club_id] = @club.id
    @members = @club.members.sort_by(&:name)
    @agendas = @club.agendas
    
    #TODO: Fix the friggin date problems

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.xml
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
    
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])
    if session[:member_id] then
      @club.members << Member.find(session[:member_id])
    end
    
    session[:club_id] = @club.id
    

    respond_to do |format|
      if @club.save
        format.html { redirect_to(@club, :notice => 'Club was successfully created.') }
#         format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
#         format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.xml
  def update
    @club = Club.find(params[:id])

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to(@club, :notice => 'Club was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.xml
  def destroy
    @club = Club.find(params[:id])
    @club.destroy
    
    respond_to do |format|
      format.html { redirect_to(clubs_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
# 
end
