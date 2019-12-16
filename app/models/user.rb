class User < ApplicationRecord
    include Tokenable
    has_secure_password
    has_one :profile, dependent: :destroy
    has_many :trip_requests, dependent: :destroy
    has_many :vehicles, dependent: :destroy
    has_many :driver_payments, dependent: :destroy
    has_many :driver_requests, dependent: :destroy
    has_many :support_tickets, dependent: :destroy
    has_many :payment_transactions, dependent: :destroy
    enum user_type: [:customer, :driver, :admin, :support]
    validates_presence_of :name, :email, :password_digest
    after_create :create_profile, :create_wallet

    def create_profile 
        Profile.create(user_id: self.id)
    end

    def create_wallet 
        Wallet.create(user_id: self.id, created_by: self.id, amount:0, current_balance:0, prev_balance:0, source:'Account creation', type: 'Initial deposit', payment_reference: '0000') if self.customer?
    end
end
