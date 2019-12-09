class Drivers::BaseController < ApplicationController

    before_action :authorize_request
    attr_reader :current_driver

    private

    def authorize_request
        @current_driver = (AuthorizeDriverRequest.new(request.headers).call)[:driver]
    end
end
