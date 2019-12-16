class CreateDriverPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :driver_payments do |t|
      t.integer :created_by
      t.string :paid_by
      t.references :user, null: false, foreign_key: true
      t.references :trip_request, null: false, foreign_key: true
      t.boolean :is_paid
      t.float :amount
      t.boolean :has_responded
      t.string :token
      t.timestamps  
    end
  end
end
