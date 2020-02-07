class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    before_action :authorize_request
    attr_reader :current_user
    private

    def authorize_request
        @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def get_active_drivers(trip)
       @request_drivers = User.driver.active.joins(:profile).where(profiles: {vehicle_type:  @trip.vehicle_type.name})
       return @request_drivers
    end
    
end
