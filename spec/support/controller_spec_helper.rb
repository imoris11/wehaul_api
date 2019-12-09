# spec/support/controller_spec_helper.rb
module ControllerSpecHelper
    # generate tokens from user id
    def token_generator(user_id)
      JsonWebToken.encode(user_id: user_id)
    end

    def driver_token_generator(id)
      JsonWebToken.encode(driver_id: id)
    end
  
    # generate expired tokens from user id
    def expired_token_generator(user_id)
      JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
    end
  
    # return valid headers
    def valid_headers
      {
        "Authorization" => token_generator(user.id),
        "Content-Type" => "application/json"
      }
    end
     # return valid headers
     def valid_driver_headers
      {
        "Authorization" => driver_token_generator(driver.id),
        "Content-Type" => "application/json"
      }
    end
  
    # return invalid headers
    def invalid_headers
      {
        "Authorization" => nil,
        "Content-Type" => "application/json"
      }
    end
  end