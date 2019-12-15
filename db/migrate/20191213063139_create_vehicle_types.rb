class CreateVehicleTypes < ActiveRecord::Migration[6.0]
  def up
    create_table :vehicle_types do |t|
      t.string :name
      t.text :description
      t.string :icon
      t.float :max_price_per_km
      t.float :min_price_per_km
      t.float :commission_rate 
      t.string :token
      t.timestamps
    end
  end

  def down
    drop_table :vehicle_types
  end
end
