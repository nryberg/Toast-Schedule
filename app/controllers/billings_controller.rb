class BillingsController < ApplicationController

  def index
    @billings = current_club.billings

  end

  def new
    @billing = Billing.new
    @club = current_club()
    # @billing.club = current_club()
    # @billing.member = current_user
  end

  def confirm
    @billing = Billing.new(
      :transaction_amount => params[:transactionAmount],
      :transaction_id     => params[:transactionId],
      :buyerEmail => params[:buyerEmail],
      :referenceId => params[:referenceId],
      :member => current_user,
      :club => current_club

    )
    if @billing.save
      redirect_to(@billing, :notice => 'Payment was successfully created.')
    else
      redirect_to :action => "index"
    end

  end

  def show
    @billing = Billing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end


  end
end
