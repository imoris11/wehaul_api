module ExceptionHandler
    extend ActiveSupport::Concern
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end

    included do
        rescue_from ActiveRecord::RecordNotFound do |e| 
            json_response({message: e.message}, :not_found ) 
        end 

        rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
        rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
        rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
        rescue_from ExceptionHandler::AuthenticationError, with: :unathorized_request
    end

    def unathorized_request(e) 
        json_response({ message: e.message }, :unauthorized)
    end

    def four_twenty_two(e)
        json_response({message: e.message}, :unprocessable_entity)
    end
end