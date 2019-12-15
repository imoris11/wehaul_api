class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  # GET /vehicles
  def index
    @vehicles = Vehicle.all.paginate(page:params[:page], per_page:20)
    json_response(@vehicles)
  end

  # GET /vehicles/1
  def show
    json_response(@vehicle)
  end

  # POST /vehicles
  def create
    @vehicle = current_user.vehicles.create!(vehicle_params)
    json_response(@vehicle, :created)
  end

  # PATCH/PUT /vehicles/1
  def update
    @vehicle.update!(vehicle_params)
    json_response(@vehicle)
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.permit(:user_id, :vehicle_type_id, :plate_number, :serial_no, :chassis_no, :license, :license_no, :license_issue_date, :license_expiry_date)
    end
end
