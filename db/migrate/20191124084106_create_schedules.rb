class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :title
      t.string :header_photo
      t.datetime :date_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
