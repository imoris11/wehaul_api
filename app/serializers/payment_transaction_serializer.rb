class PaymentTransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_ref, :medium, :amount, :token
  has_one :user
end
