class TripRequestSerializer < ActiveModel::Serializer
  attributes :id, :driver_fee, :commission, :distance, :is_approved_admin, :is_approved_user, :is_paid, :driver_paid, :trip_amount, :contact_address, :pickup_time, :fee, :pickup_date, :quantity, :token
  has_one :user
end
