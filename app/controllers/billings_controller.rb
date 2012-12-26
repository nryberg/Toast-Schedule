class BillingsController < ApplicationController

  def index

  end

  def new
    @billing = Billing.new
    @club = current_club()
    # @billing.club = current_club()
    # @billing.member = current_user
  end
end
