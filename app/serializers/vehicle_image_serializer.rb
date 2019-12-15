class VehicleImageSerializer < ActiveModel::Serializer
  attributes :id, :image, :token
  has_one :vehicle
end
