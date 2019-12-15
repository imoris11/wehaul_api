class VehicleTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :icon,  :max_price_per_km, :min_price_per_km, :token
end
