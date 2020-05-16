class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :target, :message, :is_read, :token, :created_at
  has_one :user
end
