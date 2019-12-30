class UserSerializer < ActiveModel::Serializer
  attributes :name, :role, :token, :email, :created_at, :user_type, :status
  has_one :profile
end
