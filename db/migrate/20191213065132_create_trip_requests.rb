class CreateTripRequests < ActiveRecord::Migration[6.0]
  def up
    create_table :trip_requests do |t|
      t.references :user
      t.references :vehicle_type 
      t.float :fee
      t.string :destination_address
      t.string :pickup_address
      t.datetime :eta
      t.datetime :pickup_date
      t.string :contact_email
      t.string :contact_number
      t.float :weight
      t.text :description
      t.integer :quantity
      t.integer :vehicles_qty
      t.integer :driver_id
      t.integer :created_by
      t.integer :status
      t.float :driver_fee
      t.float :commission
      t.float :distance
      t.boolean :is_approved_admin
      t.boolean :is_approved_user
      t.boolean :is_paid
      t.boolean :driver_paid
      t.float :trip_amount
      t.text :contact_address
      t.string :pickup_time
      t.string :loader
      t.string :contact_name
      t.string :token
      t.string :processed_by
      t.string :driver_name
      t.timestamps
    end
  end

  def down
    drop_table :trip_requests
  end

end
