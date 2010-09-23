class ClubsController < ApplicationController
   before_filter :get_user
  
  # GET /clubs
  # GET /clubs.xml
  def index
    @clubs = @user.clubs

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
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
    @club = @user.clubs.find(params[:id])
    
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])
    @user.clubs << @club
    @user.save

    respond_to do |format|
      if @user.save
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
    @club = @user.clubs.find(params[:id])

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
#     person.phones.delete_if{|p| p.number == '214-555-1234'}
    @club = @user.clubs.find(params[:id])
    p @club.id.to_s + " " + params[:id].to_s
    @user.clubs.delete_if{|club| club.id == @club.id}
    
    @user.save
    
    respond_to do |format|
      format.html { redirect_to(clubs_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def get_user
    @user = User.find(session[:user_id])
  end
  
 
end
