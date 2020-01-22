class Drivers::AccountsController < ApplicationController
  before_action :set_driver, only:[:show]

  def stats
    trips = TripRequest.where('driver_id=?', current_user.id).count
    active = TripRequest.where('driver_id=?', current_user.id).active.count
    sum = current_user.driver_payments.sum(:amount)
    payments = current_user.driver_payments.count
    status = current_user.status
    response ={trips:trips, active:active, sum: sum, payments: payments, status:status}
    json_response(response)
  end

  def busy
    if current_user.busy? 
      current_user.status = "active"
    else
      current_user.status = "busy"
    end
    current_user.save!
    json_response(current_user)
  end

  private

  def set_driver
    @driver = User.find_by_token!(params[:id])
  end
end
