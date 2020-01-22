class Admins::AccountsController < ApplicationController
  def index
    trips = TripRequest.trips.completed.paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def stats
    customers = User.customer.count
    drivers = User.driver.count
    active = TripRequest.trips.active.count 
    completed = TripRequest.completed.count
    response ={ users:customers, drivers:drivers, active: active, completed: completed}
    json_response(response)
  end
end
