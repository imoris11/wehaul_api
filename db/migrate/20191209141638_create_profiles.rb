class CreateProfiles < ActiveRecord::Migration[6.0]
  def up
    create_table :profiles do |t|
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
      t.references :user
      t.string :referral_name
      t.timestamps
    end
  end

  def down
  end 

end
