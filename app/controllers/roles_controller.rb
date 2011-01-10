class RolesController < ApplicationController
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
    session[:agenda_id] = params[:agenda_id]
    @role = Role.new
    
    @club = Club.find(session[:club_id])
    
    @members = @club.members

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.first(params[:id])
    @members = Club.find(session[:club_id]).members
  end

  # POST /roles
  # POST /roles.xml
  def create
    @agenda = Agenda.find(session[:agenda_id])
    @role = Role.create(params[:role])
    @agenda.roles << @role
    @agenda.save
    
    

    respond_to do |format|
      if @role.save
        format.html { redirect_to([@agenda.club, @agenda], :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @agenda, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.first(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(@role, :notice => 'Role was successfully updated.') }
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
    @role = Role.first(params[:id])
    agenda = Role.agenda
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(agenda) }
      format.xml  { head :ok }
    end
  end
end
