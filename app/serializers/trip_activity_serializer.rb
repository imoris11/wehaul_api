class TripActivitySerializer < ActiveModel::Serializer
  attributes :id, :activity, :mark_as_responded, :token
  has_one :trip_request
  has_one :user
end
