class AuthenticateDriver
    def initialize (phone_number, password)
        @phone_number = phone_number
        @password = password
    end

    def call 
       return {driver: driver,  token:JsonWebToken.encode(driver_id: driver.id)} if driver
    end

    private
    attr_reader :phone_number, :password

    def driver
        driver = Driver.find_by(phone_number: phone_number)
        return driver if driver && driver.authenticate(password)

        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end