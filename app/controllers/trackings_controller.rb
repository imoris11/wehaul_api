class TrackingsController < ApplicationController
  before_action :set_tracking, only: [:show, :update, :destroy]

  # GET /trackings
  def index
    @trackings = Tracking.all
    json_response(@trackings)
  end

  # GET /trackings/1
  def show
    json_response(@tracking)
  end

  # POST /trackings
  def create
    @tracking = Tracking.create!(tracking_params)
    json_response(@tracking, :created)
  end

  # DELETE /trackings/1
  def destroy
    @tracking.destroy
     head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracking
      @tracking = Tracking.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tracking_params
      params.permit(:location, :trip_request_id)
    end
end
