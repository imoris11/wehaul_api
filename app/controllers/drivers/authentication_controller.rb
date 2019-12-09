class Drivers::AuthenticationController < Drivers::BaseController
    skip_before_action :authorize_request, only: :authenticate
    def authenticate 
        auth_token = AuthenticateDriver.new(auth_params[:phone_number], auth_params[:password]).call
        json_response(auth_token)
    end

    private

    def auth_params
        params.permit(:phone_number, :password)
    end
end
