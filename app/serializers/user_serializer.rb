class UserSerializer < ActiveModel::Serializer
  attributes :name, :role, :token, :email, :created_at, :user_type, :status, :phone_number
  has_one :profile
end
