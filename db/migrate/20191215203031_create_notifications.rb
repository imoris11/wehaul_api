class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :target
      t.text :message
      t.boolean :is_read, :default => false
      t.references :user, null: false, foreign_key: true
      t.string :token
      t.timestamps
    end
  end

end
