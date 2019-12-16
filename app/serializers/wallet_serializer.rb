class WalletSerializer < ActiveModel::Serializer
  attributes :id, :created_by, :amount, :prev_balance, :current_balance, :payment_reference, :is_valid, :source, :type, :token
  has_one :user
end
