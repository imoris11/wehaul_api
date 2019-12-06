class UserSerializer < ActiveModel::Serializer
  attributes :id, :name,:role, :token, :email, :profile_picture, :created_at, :num_of_articles
end
