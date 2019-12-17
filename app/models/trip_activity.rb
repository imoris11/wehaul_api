class TripActivity < ApplicationRecord
  include Tokenable
  belongs_to :trip_request
  belongs_to :user

  validates_presence_of :activity
end
