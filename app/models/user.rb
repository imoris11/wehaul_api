class User < ApplicationRecord
    include Tokenable
    has_secure_password
    has_one :profile, dependent: :destroy
    has_many :trip_requests, dependent: :destroy
    has_many :vehicles, dependent: :destroy
    enum user_type: [:customer, :driver, :admin, :support]
    validates_presence_of :name, :email, :password_digest
    after_create :create_profile

    def create_profile 
        Profile.create(user_id: self.id)
    end
end
