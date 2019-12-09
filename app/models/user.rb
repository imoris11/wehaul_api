class User < ApplicationRecord
    include Tokenable
    has_secure_password
    has_one :profile, dependent: :destroy
    validates_presence_of :name, :email, :password_digest
    
end
