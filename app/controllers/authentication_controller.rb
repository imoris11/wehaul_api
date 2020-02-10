class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :authenticate
    def authenticate 
        auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
        #send_message("This is the first test message", "+2349037233559")
        json_response(auth_token)
    end

    private
    def auth_params
        params.permit(:email, :password)
    end
end
