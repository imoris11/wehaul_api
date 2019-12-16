class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :plate_number, :serial_no, :chassis_no, :token, :license, :license_no, :license_issue_date, :license_expiry_date, :token
  has_one :user
  has_one :vehicle_type
end
