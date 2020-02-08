class CreateDriverRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :driver_routes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :token
      t.timestamps
    end
  end
end
