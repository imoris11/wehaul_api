class User < ApplicationRecord
    include Tokenable
    has_secure_password
    has_one :profile, dependent: :destroy
    validates_presence_of :name, :email, :password_digest
    after_create :create_profile

    def create_profile 
        Profile.create(user_id: self.id)
    end
end
