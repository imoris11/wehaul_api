class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :vehicle_type
      t.text :resident_state
      t.string :vehicle_number
      t.text :preferred_distance
      t.text :routes
      t.string :drivers_license
      t.datetime :driver_license_expiry_date
      t.string :vehicle_license_number
      t.datetime :vehicle_license_number_expiry
      t.text :profile_picture
      t.string :account_name
      t.string :account_number
      t.string :bank_name
      t.string :account_type
      t.string :referral_name
      t.text :password_digest
      t.string :token
      t.string :phone_number
      t.timestamps
    end
  end
end
