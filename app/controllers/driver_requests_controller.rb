class DriverRequestsController < ApplicationController
  before_action :set_driver_request, only: [:show, :update, :destroy]

  # GET /driver_requests
  def index
    @driver_requests = DriverRequest.all.paginate(page:params[:page], per_page:20)
    json_response(@driver_requests)
  end

  # GET /driver_requests/1
  def show
    json_response(@driver_request)
  end

  def trip_driver_requests
    requests = DriverRequest.where('trip_request_id=?', params[:id])
    json_response(requests)
  end

  # POST /driver_requests
  def create
    @driver_request = DriverRequest.create!(driver_request_params)
    user = User.find(@driver_request.created_by)
    activity = "#{user.name} created a driver request"
    @driver_request.trip_request.trip_activities.create!({activity: activity, user_id: user.id})
    UserNotifierMailer.send_new_request_email(@driver_request.trip_request, @driver_request.user).deliver
    json_response(@driver_request, :created)
  end

  # PATCH/PUT /driver_requests/1
  def update
    @driver_request.update!(driver_request_params)
    @driver_request.trip_request.user.notifications.create!(target:'trip', message: "#{@driver_request.user.name} has accepted your trip request with a price of #{@driver_request.price}") if @driver_request.is_accepted?
    json_response(@driver_request)
  end

  # DELETE /driver_requests/1
  def destroy
    @driver_request.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_request
      @driver_request = DriverRequest.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def driver_request_params
      params.permit(:user_id, :trip_request_id, :has_responded, :is_accepted, :created_by, :price)
    end
end
