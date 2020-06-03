class DriverRequestSerializer < ActiveModel::Serializer
  attributes :id, :has_responded, :is_accepted, :created_by, :price, :token, :created_at
  has_one :user
  has_one :trip_request
end
