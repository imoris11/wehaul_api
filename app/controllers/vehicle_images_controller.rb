class VehicleImagesController < ApplicationController
  before_action :set_vehicle_image, only: [:show, :update, :destroy]

  # GET /vehicle_images
  def index
    @vehicle_images = VehicleImage.all.paginate(page:params[:page], per_page:20)
    json_response(@vehicle_images)
  end

  # GET /vehicle_images/1
  def show
   json_response(@vehicle_image)
  end

  # POST /vehicle_images
  def create
    @vehicle_image = VehicleImage.create!(vehicle_image_params)
    json_response(@vehicle_image, :created)
  end

  # PATCH/PUT /vehicle_images/1
  def update
    @vehicle_image.update!(vehicle_image_params)
    json_response(@vehicle_image)
  end

  # DELETE /vehicle_images/1
  def destroy
    @vehicle_image.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_image
      @vehicle_image = VehicleImage.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_image_params
      params.permit(:vehicle_id, :image)
    end
end
