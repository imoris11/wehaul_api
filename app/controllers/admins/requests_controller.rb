class Admins::RequestsController < ApplicationController
  before_action :set_trip_request, only: [:show_request, :update_request, :activities]
  # get all requests
  def requests
    @trip_requests = TripRequest.requests.paginate(page:params[:page], per_page:20)
    json_response(@trip_requests)
  end

  #get all user trips
  def trips
    @trip_requests = TripRequest.trips.paginate(page:params[:page], per_page:20)
    json_response(@trip_requests)
  end

  def activities
    trip_activities = @trip_request.trip_activities
    json_response(trip_activities)
  end
  #get stats for all user trips
  def trips_stats 
    @all = TripRequest.trips.count
    @completed = TripRequest.trips.completed.count
    @cancelled = TripRequest.trips.cancelled.count
    @pending = TripRequest.trips.pending.count
    @on_going = TripRequest.trips.on_going.count
    @active = TripRequest.trips.active.count
    @response = { all: @all, completed: @completed, cancelled: @cancelled, active: @active, pending: @pending, on_going: @on_going}
    json_response(@response)
  end

  def monthly_trips
    @successful = TripRequest.completed.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @active = TripRequest.active.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @cancelled = TripRequest.cancelled.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @response = {successful:@successful, active: @active, cancelled: @cancelled}
    json_response(@response)
  end

  #get stats for all user requests
  def request_stats
    @all = TripRequest.requests.count
    @trips = TripRequest.trips.count
    @cancelled = TripRequest.cancelled.requests.count
    @active = TripRequest.active.requests.count
    @response = { all: @all, trips: @trips, cancelled: @cancelled, active: @active}
    json_response(@response)
  end

  #cancelled requests
  def cancelled_requests
    cancelled = TripRequest.cancelled.requests.paginate(page:params[:page], per_page:20)
    json_response(cancelled)
  end
  
  #active requests
  def active_requests 
    pending = TripRequest.active.requests.paginate(page:params[:page], per_page:20)
    json_response(pending)
  end

  #completed trips

  def completed_trips
    @completed = TripRequest.completed.trips.paginate(page:params[:page], per_page:20)
    json_response(@completed)
  end

  def cancelled_trips
    @cancelled = TripRequest.cancelled.trips.paginate(page:params[:page], per_page:20)
    json_response(@cancelled)
  end

  def on_going_trips 
    @trips = TripRequest.on_going.trips.paginate(page:params[:page], per_page:20)
    json_response(@trips)
  end

  def pending_trips 
    @trips = TripRequest.pending.trips.paginate(page:params[:page], per_page:20)
    json_response(@trips)
  end
  # POST /trip_requests
  def create_request
    @trip_request = TripRequest.create!(trip_request_params)
    @trip = TripRequest.find_by_token!(@trip_request.token)
    UserNotifierMailer.send_user_request_email(@trip, @trip_request.user).deliver
    drivers = get_active_drivers(@trip)
    drivers.each do |driver|
      DriverRequest.create!({user_id: driver.id, trip_request_id: @trip_request.id, created_by: current_user.id, price: @trip_request.driver_fee})
      UserNotifierMailer.send_new_request_email(@trip_request, driver).deliver
    end
    json_response(@trip_request, :created)
  end

  # GET /trip_requests/1
  def show_request
    json_response(@trip_request)
  end

  # PATCH/PUT /trip_requests/1
  def update_request
    @trip_request.update!(trip_request_params)
    if @trip_request.completed?
       UserNotifierMailer.send_trip_completed_email(@trip_request).deliver
    else
      UserNotifierMailer.send_trip_update_email(@trip_request).deliver
    end
    json_response(@trip_request)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trip_request
    @trip_request = TripRequest.find_by_token!(params[:id])
  end
  # Only allow a trusted parameter "white list" through.
  def trip_request_params
    params.permit(:driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :weight, :vehicle_type_id, :driver_id, :contact_email, :contact_number, :status, :loader, :contact_name, :destination_address, :pickup_address, :created_by, :driver_id, :user_id, :vehicles_qty, :description, :destination_state, :pickup_state)
  end
end
