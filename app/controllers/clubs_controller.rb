class ClubsController < ApplicationController
  
  # GET /clubs
  # GET /clubs.xml
  def index
    @clubs = Club.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @user = User.find(params[:user_id])
    @club = @user.clubs.find(params[:id])

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
    @user = User.find(params[:user_id])
    @club = @user.clubs.find(params[:id])
    
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @user = User.find(params[:user_id])
    @club = Club.new(params[:club])
    @user.clubs << @club
    @user.save
    
    p @club.name
    p @user.clubs.count

    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_path(@user), :notice => 'Club was successfully created.') }
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
 
end
