class TripRequestsController < ApplicationController
  before_action :set_trip_request, only: [:show, :update, :destroy]

  # GET /trip_requests
  def index
    @trip_requests = TripRequest.all.paginate(page:params[:page], per_page:20)
    json_response(@trip_requests)
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
    json_response(@trip_request)
  end

  # DELETE /trip_requests/1
  def destroy
    @trip_request.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_request
      @trip_request = TripRequest.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_request_params
      params.permit(:driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :weight, :vehicle_type_id)
    end
end
