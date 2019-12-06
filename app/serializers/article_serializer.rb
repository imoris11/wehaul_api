class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :header_photo, :created_at, :token, :views, :photo_caption
  belongs_to :user
  belongs_to :category
end
