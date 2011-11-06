class RoleTypesController < ApplicationController
  before_filter :authenticate
  
  # GET /roles
  # GET /roles.xml
  def index
    @role_types = RoleType.sort(:name).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @role_types }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role_type = RoleType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role_type }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role_type = RoleType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role_type }
    end
  end

  # GET /roles/1/edit
  def edit
    @role_type = RoleType.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role_type = RoleType.new(params[:role_type])

    respond_to do |format|
      if @role_type.save
        format.html { redirect_to(role_types_path, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => role_types_path, :status => :created, :location => @role_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role_type = RoleType.find(params[:id])

    respond_to do |format|
      if @role_type.update_attributes(params[:role_type])
        format.html { redirect_to(role_types_path, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role_type = RoleType.find(params[:id])
    @role_type.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
  
  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "nryberg" && password == "zookies"
    end
  end
  
end
