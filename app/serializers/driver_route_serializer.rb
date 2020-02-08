class DriverRouteSerializer < ActiveModel::Serializer
  attributes :id, :location, :token
  has_one :user
end
