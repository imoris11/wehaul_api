class Admins::AccountsController < ApplicationController
  def index
    trips = TripRequest.where("created_by=?", current_user.id).paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def stats
    customers = User.customer.count
    drivers = User.driver.count
    active = TripRequest.active.trips.count 
    completed = TripRequest.completed.trips.count
    response ={ users:customers, drivers:drivers, active: active, completed: completed}
    json_response(response)
  end
end
