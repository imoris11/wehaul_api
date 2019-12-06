class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :video_url
      t.text :token
      t.integer :views
      t.string :header_photo
      t.timestamps
    end
  end
end
