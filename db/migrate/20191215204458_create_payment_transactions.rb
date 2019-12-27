class CreatePaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :transaction_ref
      t.string :medium
      t.float :amount
      t.string :deposit_type
      t.string :message
      t.string :token
      t.timestamps  
    end
  end
end
