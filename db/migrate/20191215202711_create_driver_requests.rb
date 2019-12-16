class CreateDriverRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :driver_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trip_request, null: false, foreign_key: true
      t.boolean :has_responded, :default => false
      t.boolean :is_accepted, :default => false
      t.integer :created_by
      t.float :price
      t.string :token
      t.timestamps
    end
  end
end
