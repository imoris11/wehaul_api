class Wallet < ApplicationRecord
  include Tokenable
  belongs_to :user
  validates_presence_of :created_by, :amount, :source, :type, :payment_reference
end
