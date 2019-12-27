class User < ApplicationRecord
    include Tokenable
    has_secure_password
    has_one :profile, dependent: :destroy
    has_one :wallet, dependent: :destroy
    has_many :trip_requests, dependent: :destroy
    has_many :trip_activities, dependent: :destroy
    has_many :vehicles, dependent: :destroy
    has_many :driver_payments, dependent: :destroy
    has_many :driver_requests, dependent: :destroy
    has_many :support_tickets, dependent: :destroy
    has_many :payment_transactions, dependent: :destroy
    has_many :notifications, dependent: :destroy
    enum user_type: [:customer, :driver, :admin, :support]
    validates_presence_of :name, :email, :password_digest
    after_create :create_profile
    after_create :create_wallet

    def create_profile 
        Profile.create(user_id: self.id)
    end

    def create_wallet 
        Wallet.create(user_id: self.id, current_balance:0) if self.customer?
    end
end
