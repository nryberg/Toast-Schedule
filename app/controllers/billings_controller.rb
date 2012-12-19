class BillingsController < ApplicationController

  def index

  end

  def new
    @billing = Billing.new
    @billing.club = current_club()
    @billing.member = current_user
  end
end
