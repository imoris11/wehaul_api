class TripRequestSerializer < ActiveModel::Serializer
  attributes :id, :driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :token, :driver_id, :status, :weight, :contact_number, :status, :loader, :contact_name, :contact_email
  has_one :user
  has_one :vehicle_type
end
