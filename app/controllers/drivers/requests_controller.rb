class Drivers::RequestsController < ApplicationController
  def index
    trips = TripRequest.where("driver_id=?", current_user.id).paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def history
    trips = TripRequest.where('driver_id=?', current_user.id).completed.paginate(page:params[:page], per_page:10)
    json_response(trips)
  end

  def cancelled
    trips = TripRequest.where('driver_id=?', current_user.id).cancelled.paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def on_going 
    trips = TripRequest.where('driver_id=?', current_user.id).on_going.paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def completed 
    trips = TripRequest.where('driver_id=?', current_user.id).completed.paginate(page:params[:page], per_page:20)
    json_response(trips)
  end

  def pending
    trips = TripRequest.where('driver_id=?', current_user.id).pending.paginate(page:params[:page], per_page:10)
    json_response(trips)
  end

  def driver_requests
    requests = current_user.driver_requests.paginate(page:params[:page],per_page:20)
    json_response(requests)
  end

  def driver_stats
    all = User.driver.count
    busy = User.driver.busy.count
    banned = User.driver.banned.count
    available = all - busy - banned
    response = { all: all, busy: busy, banned: banned, available: available } 
    json_response(response)
  end

  def stats
    trips = TripRequest.where('driver_id=?', current_user.id).count
    active = TripRequest.where('driver_id=?', current_user.id).active.count
    cancelled = TripRequest.where('driver_id=?', current_user.id).cancelled.count
    completed = TripRequest.where('driver_id=?', current_user.id).completed.count
    response ={trips:trips, active:active, completed:completed, cancelled:cancelled}
    json_response(response)
  end

end