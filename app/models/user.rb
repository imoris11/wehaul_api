class User < ApplicationRecord
    include Tokenable
    has_secure_password

    validates_presence_of :name, :email, :password_digest
    
end
