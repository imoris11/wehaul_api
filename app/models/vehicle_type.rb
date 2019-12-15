class VehicleType < ApplicationRecord
  include Tokenable
  has_many :vehicle, dependent: :destroy

  validates_presence_of :name, :description, :max_price_per_km, :min_price_per_km
end
