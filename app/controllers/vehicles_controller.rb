class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]
  before_action :set_driver, only: [:create_vehicle]
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

  def create_vehicle
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user_id = @driver.id
    @vehicle.save!
    update_vehicle_images(@vehicle)
    json_response(@vehicle, :created)
  end

  # PATCH/PUT /vehicles/1
  def update
    @vehicle.update!(vehicle_params)
    update_vehicle_images(@vehicle)
    json_response(@vehicle)
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle.destroy
    head :no_content
  end

  private

  def update_vehicle_images (vehicle)
     params[:vehicle_images].each do |link|
      vehicle.vehicle_images.create!({image: link})
    end
    vehicle.user.profile.update!({vehicle_type: vehicle.vehicle_type.name})
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find_by_token!(params[:id])
    end

    def set_driver
      @driver = User.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.permit(:user_id, :vehicle_type_id, :plate_number, :serial_no, :chassis_no, :license, :license_no, :license_issue_date, :license_expiry_date)
    end
end
