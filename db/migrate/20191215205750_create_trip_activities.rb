class CreateTripActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_activities do |t|
      t.string :action
      t.references :trip_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :mark_as_responded
      t.string :token
      t.timestamps
    end
  end
end
