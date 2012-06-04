class RolesController < ApplicationController


  def up
    @role = Role.find(params[:id])
    @role.move_up
    @role.save
    @meeting = @role.meeting
    respond_to do |format|
        format.html { redirect_to(@meeting, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
    end
  end 

  def down
    @role = Role.find(params[:id])
    @role.move_down
    @role.save
    @meeting = @role.meeting
    respond_to do |format|
        format.html { redirect_to(@meeting, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
    end
  end 
 # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end



  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.first(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    session[:meeting_id] = params[:meeting_id]
    @role = Role.new
    @meeting = Meeting.find(session[:meeting_id])
        

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
    @members = Club.find(session[:club_id]).members
    @meeting = Meeting.find(params[:meeting_id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @meeting = Meeting.find(session[:meeting_id])
    @role = Role.create(params[:role])
    @role.ordinal = @meeting.last_role.ordinal + 1
    @meeting.roles << @role
    @meeting.save
   
    #TODO: fix this save above - is it really necessary?
    

    respond_to do |format|
      if @role.save
        format.html { redirect_to(@meeting, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @meeting, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])
    @meeting = @role.meeting

    respond_to do |format|
      if @role.update_attributes(params[:role])
        @meeting.refactor_roles
        format.html { redirect_to([@role.meeting.club, @role.meeting], :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    p "Yes I'm in delete"
    @role = Role.find(params[:id])
    @meeting = @role.meeting
    @role.destroy
    @meeting.refactor_roles
    p @meeting

    respond_to do |format|
      format.html { redirect_to([@meeting.club, @meeting]) }
      format.xml  { head :ok }
    end
  end
end
