class Drivers::TripActivitiesController < ApplicationController
  
  def index 
    activities = []
    trips = TripRequest.where('driver_id=?', current_user.id).paginate(page:params[:page], per_page:5)
    trips.each do |trip|
       trip.trip_activities.each do |activity|
        activities<<activity
       end
    end
    json_response({activities:activities})
  end

end