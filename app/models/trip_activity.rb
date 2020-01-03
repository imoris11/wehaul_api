class TripActivity < ApplicationRecord
  include Tokenable
  belongs_to :trip_request
  belongs_to :user
  default_scope {order('created_at DESC')}
  validates_presence_of :activity
end
