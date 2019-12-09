class UserSerializer < ActiveModel::Serializer
  attributes :name, :role, :token, :email, :created_at
  has_one :profile
end
