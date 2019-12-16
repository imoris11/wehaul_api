class DriverRequest < ApplicationRecord
  include Tokenable
  belongs_to :user
  belongs_to :trip_request

  validates_presence_of :price
end
