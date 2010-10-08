class MembersController < ApplicationController
    # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
    
  end

  def show
    @member = Member.find(params[:id])
    @club = Club.find(params[:club_id])

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
#     @club = Club.find(params[:club_id])
    @member = @club.members.create(params[:member])
#     @member[:club_id] = params[:club_id]
#     @club = Club.find(params[:club_id])

    respond_to do |format|
      if @member.save
        format.html { redirect_to(@club, :notice => 'Member was successfully created.') }
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
#     person.phones.delete_if{|p| p.number == '214-555-1234'}
    @member = Member.find(params[:id])
    @club = Club.find(@member.club_id)
    @member.destroy
    
    
    respond_to do |format|
      format.html { redirect_to(@club) }
      format.xml  { head :ok }
    end
  end
  

end
