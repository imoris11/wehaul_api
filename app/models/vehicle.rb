class Vehicle < ApplicationRecord
  include Tokenable
  belongs_to :user
  belongs_to :vehicle_type
  has_many :vehicle_images

  validates_presence_of :plate_number,  :license_no, :license_issue_date, :license_expiry_date, :license
end
