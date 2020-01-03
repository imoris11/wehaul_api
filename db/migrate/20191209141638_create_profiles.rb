class CreateProfiles < ActiveRecord::Migration[6.0]
  def up
    create_table :profiles do |t|
      t.text :address
      t.string :gender
      t.string :vehicle_type
      t.text :resident_state
      t.string :city
      t.string :country
      t.string :vehicle_number
      t.text :preferred_distance
      t.text :routes
      t.string :drivers_license
      t.datetime :driver_license_expiry_date
      t.datetime :driver_license_issue_date
      t.text :profile_picture
      t.string :account_name
      t.string :account_number
      t.string :bank_name
      t.string :account_type
      t.references :user, null: false, foreign_key: true
      t.string :referral_name
      t.string :company_name
      t.boolean :is_verified, :default => true
      t.boolean :is_confirmed, :default => false
      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end 

end
