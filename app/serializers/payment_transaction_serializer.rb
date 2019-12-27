class PaymentTransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_ref, :medium, :amount, :message, :deposit_type, :token
  has_one :user
end
