class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :address, :resident_state, :city, :country,  :preferred_distance, :routes, :drivers_license, :driver_license_expiry_date, :profile_picture, :account_name, :account_number, :bank_name, :account_type, :referral_name, :vehicle_type, :driver_license_issue_date, :company_name, :gender
  has_one :user
end
