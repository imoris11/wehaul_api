class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :target, :message, :is_read, :token
  has_one :user
end
