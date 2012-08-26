class PlatesController < ApplicationController
  # GET /plates
  # GET /plates.xml

  def index
    @template = Template.find(params[:template_id])
    @plates = @template.plates.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plates }
    end
  end

  # GET /plates/1
  # GET /plates/1.xml
  def show
    @plate = Plate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plate }
    end
  end

  # GET /plates/new
  # GET /plates/new.xml
  def new
    @plate = Plate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plate }
    end
  end

  # GET /plates/1/edit
  def edit
    @plate = Plate.find(params[:id])
  end

  # POST /plates
  # POST /plates.xml
  def create
    @plate = Plate.new(params[:plate])

    respond_to do |format|
      if @plate.save
        format.html { redirect_to(@plate, :notice => 'Plate was successfully created.') }
        format.xml  { render :xml => @plate, :status => :created, :location => @plate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plates/1
  # PUT /plates/1.xml
  def update
    @plate = Plate.find(params[:id])

    respond_to do |format|
      if @plate.update_attributes(params[:plate])
        format.html { redirect_to(@plate, :notice => 'Plate was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plates/1
  # DELETE /plates/1.xml
  def destroy
    @plate = Plate.find(params[:id])
    @plate.destroy

    respond_to do |format|
      format.html { redirect_to(plates_url) }
      format.xml  { head :ok }
    end
  end
end
