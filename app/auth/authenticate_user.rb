class AuthenticateUser
    def initialize (email, password)
        @email = email
        @password = password
    end

    def call 
       return {user: user,  token:JsonWebToken.encode(user_id: user.id), profile:user.profile} if user
    end

    private
    attr_reader :email, :password

    def user
        user = User.find_by(email: email)
        return user if user && user.authenticate(password)

        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end