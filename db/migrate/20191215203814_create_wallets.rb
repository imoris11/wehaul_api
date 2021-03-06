class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :created_by
      t.float :current_balance
      t.string :token
      t.timestamps
    end
  end
end
