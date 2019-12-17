class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :created_by
      t.float :amount
      t.float :prev_balance
      t.float :current_balance
      t.text :payment_reference
      t.boolean :is_valid
      t.string :source
      t.string :deposit_type
      t.string :token
      t.timestamps
    end
  end
end
