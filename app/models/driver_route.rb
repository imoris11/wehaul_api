class DriverRoute < ApplicationRecord
  include Tokenable
  belongs_to :user
  validates_presence_of :location
end
