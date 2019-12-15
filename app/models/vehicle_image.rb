class VehicleImage < ApplicationRecord
  include Tokenable
  belongs_to :vehicle
  validates_presence_of :image
end
