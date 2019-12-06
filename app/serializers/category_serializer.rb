class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :token
  has_many :articles
  has_many :videos
end
