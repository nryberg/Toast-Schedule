class AgendasController < ApplicationController
  # GET /agendas
  # GET /agendas.xml
  def index
    @agendas = Agenda.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendas }
    end
  end

  # GET /agendas/1
  # GET /agendas/1.xml
  def show
    @club = Club.find(params[:club_id])
    
    @agenda = @club.agendas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /agendas/new
  # GET /agendas/new.xml
  def new
    @club = Club.find(session[:club_id])
    
    @agenda = Agenda.new
    @club.agendas << @agenda

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /agendas/1/edit
  def edit
    @club = Club.find(session[:club_id])
    @agenda = @club.agendas.find(params[:id])
    
  end

  # POST /agendas
  # POST /agendas.xml
  def create
    p "At create"
    @club = Club.find(session[:club_id])
    
    @agenda = Agenda.new(params[:agenda])
    @club.agendas << @agenda
    @club.save
    
    respond_to do |format|
      if @agenda.save
        format.html { redirect_to(@club, :notice => 'Agenda was successfully created.') }
        format.xml  { render :xml => @club, :status => :created, :location => @club}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agendas/1
  # PUT /agendas/1.xml
  def update
    @club = Club.find(session[:club_id])
    @agenda = @club.agendas.find(params[:id])
    respond_to do |format|
      if @agenda.update_attributes(params[:agenda])
        format.html { redirect_to(@club, :notice => 'Agenda was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.xml
  def destroy
    @agenda = Agenda.first(params[:id])
    @agenda.destroy

    respond_to do |format|
      format.html { redirect_to(agendas_url) }
      format.xml  { head :ok }
    end
  end
end
