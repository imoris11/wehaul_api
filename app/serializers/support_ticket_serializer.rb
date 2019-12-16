class SupportTicketSerializer < ActiveModel::Serializer
  attributes :id, :mark_as_read, :is_resolved, :content, :topic, :token
  has_one :user
  has_one :trip_request
end
