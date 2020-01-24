class TripRequestsController < ApplicationController
  before_action :set_trip_request, only: [:show, :update, :destroy, :activities, :pay]

  # get all requests
  def index
      @trip_requests = current_user.trip_requests.requests.paginate(page:params[:page], per_page:20)
      json_response(@trip_requests)
  end
  #Get trip activities
  def activities
    trip_activities = @trip_request.trip_activities
    json_response(trip_activities)
  end
  #get all user trips
  def trips
      @trip_requests = current_user.trip_requests.trips.paginate(page:params[:page], per_page:20)
      json_response(@trip_requests)
  end

  #get stats for all user trips
  def trips_stats 
    @all = current_user.trip_requests.trips.count
    @completed = current_user.trip_requests.trips.completed.count
    @cancelled = current_user.trip_requests.trips.cancelled.count
    @pending = current_user.trip_requests.trips.pending.count
    @on_going = current_user.trip_requests.trips.on_going.count
    @active = current_user.trip_requests.trips.active.count
    @stats = current_user.trip_requests.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @response = { all: @all, completed: @completed, cancelled: @cancelled, active: @active, trips:@stats, pending: @pending, on_going: @on_going }
    json_response(@response)
  end

  #get stats for all user requests
  def request_stats
    @all = current_user.trip_requests.requests.count
    @completed = current_user.trip_requests.completed.requests.count
    @cancelled = current_user.trip_requests.cancelled.requests.count
    @active = current_user.trip_requests.active.requests.count
    @stats = current_user.trip_requests.requests.group_by_month(:created_at, format: "%b", reverse:true).count
    @response = { all: @all, completed: @completed, cancelled: @cancelled, active: @active, requests: @stats }
    json_response(@response)
  end

  #cancelled requests
  def cancelled_requests
    cancelled = current_user.trip_requests.cancelled.requests.paginate(page:params[:page], per_page:20)
    json_response(cancelled)
  end
  
  #active requests
  def active_requests 
    pending = current_user.trip_requests.active.requests.paginate(page:params[:page], per_page:20)
    json_response(pending)
  end

  #completed trips

  def completed_trips
    @completed = current_user.trip_requests.completed.trips.paginate(page:params[:page], per_page:20)
    json_response(@completed)
  end

  def cancelled_trips
    @cancelled = current_user.trip_requests.cancelled.trips.paginate(page:params[:page], per_page:20)
    json_response(@cancelled)
  end

  def on_going_trips 
    @trips = current_user.trip_requests.on_going.trips.paginate(page:params[:page], per_page:20)
    json_response(@trips)
  end

  def pending_trips 
    @trips = current_user.trip_requests.pending.trips.paginate(page:params[:page], per_page:20)
    json_response(@trips)
  end

  # GET /trip_requests/1
  def show
    json_response(@trip_request)
  end

  # POST /trip_requests
  def create
    @trip_request = current_user.trip_requests.create!(trip_request_params)
    json_response(@trip_request, :created)
  end

  # PATCH/PUT /trip_requests/1
  def update
    @trip_request.update!(trip_request_params)
    @trip_request.trip_activities.create!({ activity: params[:activity], user_id: params[:activity_user]}) if params[:activity].present?
    json_response(@trip_request)
  end

  # DELETE /trip_requests/1
  def destroy
    @trip_request.destroy
    head :no_content
  end

  def pay
    current_balance = current_user.wallet.current_balance
    current_balance = current_balance - @trip_request.trip_amount
    current_user.wallet.update!({current_balance: current_balance })
    current_user.payment_transactions.create(medium:'wallet', amount: @trip_request.trip_amount, transaction_ref: @trip_request.token , message:"paid for trip #{@trip_request.token}", deposit_type: "trip request payment")
    payment = DriverPayment.create!({user_id: @trip_request.driver_id, trip_request_id: @trip_request.id, amount: @trip_request.trip_amount * 0.5, created_by:current_user.id, paid_by: @trip_request.processed_by, is_paid:true })
    @trip_request.update!({is_paid:true})
    @trip_request.trip_activities.create!({ activity: "#{current_user.name} paid for the trip", user_id: current_user.id })
    json_response({message:'payment_successful', current_balance: current_balance})

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_request
      @trip_request = TripRequest.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_request_params
      params.permit(:driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :weight, :vehicle_type_id, :driver_id, :contact_email, :contact_number, :status, :loader, :contact_name, :destination_address, :pickup_address, :created_by, :driver_id, :vehicles_qty, :description, :processed_by, :driver_name)
    end
end
