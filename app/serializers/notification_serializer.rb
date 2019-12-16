class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :target, :messsage, :is_read, :token
  has_one :user
end
