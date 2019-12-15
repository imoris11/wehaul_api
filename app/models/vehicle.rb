class Vehicle < ApplicationRecord
  include Tokenable
  belongs_to :user
  belongs_to :vehicle_type
  has_many :vehicle_image

  validates_presence_of :plate_number, :license, :license_no, :serial_no, :license_issue_date, :license_expiry_date
end
