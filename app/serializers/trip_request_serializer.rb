class TripRequestSerializer < ActiveModel::Serializer
  attributes :id, :driver_fee, :vehicle_type_id, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :token, :driver_id, :status, :weight, :contact_number, :status, :loader, :destination_state, :pickup_state, :contact_name, :contact_email, :destination_address, :pickup_address, :vehicles_qty, :description, :created_by, :created_at, :driver_name, :processed_by, :updated_at
  has_one :user
  has_one :vehicle_type
end
