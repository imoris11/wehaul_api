class Tracking < ApplicationRecord
  include Tokenable
  belongs_to :trip_request
  default_scope {order('created_at DESC')}
  validates_presence_of :location
end
