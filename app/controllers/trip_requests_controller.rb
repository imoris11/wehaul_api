class TripRequestsController < ApplicationController
  before_action :set_trip_request, only: [:show, :update, :destroy, :activities, :pay, :accepted_driver_requests, :assign]

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
    @monthly_successful = current_user.trip_requests.completed.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @monthly_pending = current_user.trip_requests.pending.trips.group_by_month(:created_at, format: "%b", reverse:true).count
    @response = { all: @all, completed: @completed, cancelled: @cancelled, active: @active, monthly_pending:@monthly_pending, monthly_successful:@monthly_successful, pending: @pending, on_going: @on_going }
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
     @trip = TripRequest.find_by_token!(@trip_request.token)
    drivers = get_active_drivers(@trip)
    UserNotifierMailer.send_user_request_email(@trip, current_user)
    drivers.each do |driver|
      DriverRequest.create!({user_id: driver.id, trip_request_id: @trip.id, created_by: current_user.id, price: @trip.fee})
      send_message("A new trip matching your route has been requested. Check your email/dashbaord for more information.", @driver.phone_number)
      UserNotifierMailer.send_new_request_email(@trip_request, driver).deliver
    end
    json_response(@trip_request, :created)
  end

  # PATCH/PUT /trip_requests/1
  def update
    update_helper
  end

  def assign
    @driver = User.find(params[:driver_id])
    send_message("You have been assigned the trip #{@trip_request.token}, you can contact #{@trip_request.user.name} on #{@trip_request.user.phone_number}. Check your email/dashbaord for more information.", @driver.phone_number)
    send_message("You trip, #{@trip_request.token},  been assigned to #{@driver.name}. You can contact #{@driver.name} on #{@driver.phone_number}. Check your email/dashbaord for more information.", @trip_request.user.phone_number)
    UserNotifierMailer.send_assignment_email(@trip_request, @driver).deliver
    update_helper
  end

  # DELETE /trip_requests/1
  def destroy
    @trip_request.destroy
    head :no_content
  end

  def pay
    #update user balance
    current_balance = current_user.wallet.current_balance
    current_balance = current_balance - @trip_request.trip_amount
    current_user.wallet.update!({current_balance: current_balance })
    #add to payment transactions
    current_user.payment_transactions.create(medium:'wallet', amount: @trip_request.trip_amount, transaction_ref: @trip_request.token , message:"paid for trip #{@trip_request.token}", deposit_type: "trip request payment")
    #create driver payment
    payment = DriverPayment.create!({user_id: @trip_request.driver_id, trip_request_id: @trip_request.id, amount: @trip_request.driver_fee * 0.5, created_by:current_user.id, paid_by: @trip_request.processed_by, is_paid:true })
    #update trip request
    @trip_request.update!({is_paid:true})
    @trip_request.trip_activities.create!({ activity: "#{current_user.name} paid for the trip", user_id: current_user.id })
    #Send email notifications
    @driver = User.find(@trip_request.driver_id)
    UserNotifierMailer.send_payment_notification_admin(@trip_request).deliver
    send_message("A payment of #{@trip_request.driver_fee * 0.5} has been made to your account. Check your dashbaord for more information.", @driver.phone_number)
    UserNotifierMailer.send_payment_notification_driver(@trip_request.driver_id, @trip_request.driver_fee * 0.5).deliver
    #respond 
    json_response({message:'payment_successful', current_balance: current_balance})

  end

  def accepted_driver_requests
    requests = @trip_request.driver_requests.accepted.all
    json_response(requests)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_request
      @trip_request = TripRequest.find_by_token!(params[:id])
    end

    def update_helper
      @trip_request.update!(trip_request_params)
      if @trip_request.completed?
        UserNotifierMailer.send_trip_completed_email(@trip_request).deliver
        send_message("#{@trip_request.user.name}, your request #{@trip_request.token} has been completed. Check your email/dashbaord for more information.", @trip_request.user.phone_number)
      else
        UserNotifierMailer.send_trip_update_email(@trip_request).deliver
      end
      @trip_request.trip_activities.create!({ activity: params[:activity], user_id: params[:activity_user]}) if params[:activity].present?
      json_response(@trip_request)
    end

    # Only allow a trusted parameter "white list" through.
    def trip_request_params
      params.permit(:driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :weight, :vehicle_type_id, :driver_id, :contact_email, :contact_number, :status, :loader, :contact_name, :destination_address, :pickup_address, :created_by, :driver_id, :vehicles_qty, :description, :processed_by, :driver_name, :destination_state, :pickup_state)
    end
end
