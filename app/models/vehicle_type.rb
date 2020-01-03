class VehicleType < ApplicationRecord
  include Tokenable
  has_many :vehicle, dependent: :destroy
  default_scope {order('created_at DESC')}
  validates_presence_of :name, :description, :max_price_per_km, :min_price_per_km
end
