class CreateVehicles < ActiveRecord::Migration[6.0]
  def up
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vehicle_type, null: false, foreign_key: true
      t.string :plate_number
      t.string :serial_no
      t.string :chassis_no
      t.string :license
      t.string :license_no
      t.string :license_expiry_date
      t.string :license_issue_date
      t.string :token
      t.timestamps
    end
  end

  def down
    drop_table :vehicles
  end
end
