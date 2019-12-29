class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password_digest
      t.string :phone_number
      t.boolean :banned, :default => false
      t.boolean :busy, :default => false
      t.string :role
      t.boolean :admin, :default => false
      t.integer :user_type
      t.text :token
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
