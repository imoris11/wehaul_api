class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password_digest
      t.string :profile_picture
      t.integer :num_of_articles, :default => 0
      t.string :phone_number
      t.string :role
      t.boolean :admin, :default => false
      t.text :token
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
