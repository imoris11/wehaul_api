class TripRequest < ApplicationRecord
  include Tokenable
  enum status: [:pending, :in_negotiation, :on_going, :completed, :cancelled]
  belongs_to :user
  belongs_to :vehicle_type

  validates_presence_of :fee, :weight, :pickup_time, :pickup_date, :quantity

end
