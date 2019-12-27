class WalletSerializer < ActiveModel::Serializer
  attributes :id,  :current_balance, :token
  has_one :user
end
