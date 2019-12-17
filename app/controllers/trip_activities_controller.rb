class TripActivitiesController < ApplicationController
  before_action :set_trip_activity, only: [:show, :update, :destroy]

  # GET /trip_activities
  def index
    @trip_activities = TripActivity.all.paginate(page:params[:page], per_page:20)
    json_response(@trip_activities)
  end

  # GET /trip_activities/1
  def show
    json_response(@trip_activity) 
  end

  # POST /trip_activities
  def create
    @trip_activity = current_user.trip_activities.create!(trip_activity_params)
    json_response(@trip_activity, :created)
  end

  # PATCH/PUT /trip_activities/1
  def update
    @trip_activity.update!(trip_activity_params)
    json_response(@trip_activity) 
  end

  # DELETE /trip_activities/1
  def destroy
    @trip_activity.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_activity
      @trip_activity = TripActivity.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_activity_params
      params.permit(:activity, :trip_request_id, :user_id, :mark_as_responded)
    end
end
