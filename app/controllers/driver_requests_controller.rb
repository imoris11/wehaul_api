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

  # POST /driver_requests
  def create
    @driver_request = DriverRequest.create!(driver_request_params)
    json_response(@driver_request, :created)
  end

  # PATCH/PUT /driver_requests/1
  def update
    @driver_request.update!(driver_request_params)
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
