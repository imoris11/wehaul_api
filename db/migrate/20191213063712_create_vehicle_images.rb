class CreateVehicleImages < ActiveRecord::Migration[6.0]
  def up
    create_table :vehicle_images do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :image
      t.string :token
      t.timestamps
    end
  end

  def down
    drop_table :vehicle_images
  end
end
