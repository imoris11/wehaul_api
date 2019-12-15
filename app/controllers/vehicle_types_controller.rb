class VehicleTypesController < ApplicationController
  before_action :set_vehicle_type, only: [:show, :update, :destroy]

  # GET /vehicle_types
  def index
    @vehicle_types = VehicleType.all.paginate(page:params[:page], per_page:20)
    json_response(@vehicle_types)
  end

  # GET /vehicle_types/1
  def show
   json_response(@vehicle_type)
  end

  # POST /vehicle_types
  def create
    @vehicle_type = VehicleType.create!(vehicle_type_params)
    json_response(@vehicle_type, :created)
  end

  # PATCH/PUT /vehicle_types/1
  def update
    @vehicle_type.update!(vehicle_type_params)
    json_response(@vehicle_type)
  end

  # DELETE /vehicle_types/1
  def destroy
    @vehicle_type.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_type
      @vehicle_type = VehicleType.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_type_params
      params.permit(:name, :description, :max_price_per_km, :min_price_per_km, :icon)
    end
end
