class TripActivitySerializer < ActiveModel::Serializer
  attributes :id, :activity, :mark_as_responded, :created_at, :token
  has_one :trip_request
end
