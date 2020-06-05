class TrackingSerializer < ActiveModel::Serializer
  attributes :id, :location, :token, :created_at
  has_one :trip_request
end
