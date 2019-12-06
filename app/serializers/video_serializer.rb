class VideoSerializer < ActiveModel::Serializer
  attributes :id, :token, :title, :video_url, :created_at, :updated_at, :views, :header_photo
  belongs_to :user
  belongs_to :category
end
