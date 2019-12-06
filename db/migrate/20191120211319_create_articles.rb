class CreateArticles < ActiveRecord::Migration[6.0]
  def up
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.text :photo_caption
      t.text :header_photo
      t.references :category, null: false, foreign_key: true
      t.text :token
      t.references :user, null: false, foreign_key: true
      t.integer :views
      t.timestamps
    end
  end

  def down
    drop_table :articles
  end
end