class CreateSupportTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :support_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trip_request, null: false, foreign_key: true
      t.boolean :mark_as_read
      t.boolean :is_resolved
      t.text :content
      t.string :topic
      t.string :token
      t.timestamps  
    end
  end
end
