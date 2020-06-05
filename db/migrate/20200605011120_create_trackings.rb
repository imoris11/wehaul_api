class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.string :location
      t.string :token
      t.references :trip_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
