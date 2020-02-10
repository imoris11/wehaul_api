class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    include SmsHandler
    before_action :authorize_request
    attr_reader :current_user
    private

    def authorize_request
        @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def get_active_drivers(trip)
       @request_drivers = User.driver.active.joins(:profile, :driver_routes).where(profiles: {vehicle_type:  @trip.vehicle_type.name}, driver_routes: {location: @trip.destination_state}, driver_routes: {location: @trip.pickup_state} )
       return @request_drivers
    end
    
end
