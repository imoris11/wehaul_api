class PaymentTransaction < ApplicationRecord
  include Tokenable
  belongs_to :user

  validates_presence_of :medium, :amount, :transaction_ref
end
