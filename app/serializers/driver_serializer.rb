class DriverSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :vehicle_type, :resident_state, :vehicle_number, :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date, :vehicle_license_number, :vehicle_license_number_expiry, :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name, :phone_number, :token, :email
end
