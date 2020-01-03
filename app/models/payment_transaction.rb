class PaymentTransaction < ApplicationRecord
  include Tokenable
  belongs_to :user
  default_scope {order('created_at DESC')}
  validates_presence_of :medium, :amount, :transaction_ref
end
