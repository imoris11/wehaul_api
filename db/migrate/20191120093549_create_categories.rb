class CreateCategories < ActiveRecord::Migration[6.0]
  def up
    create_table :categories do |t|
      t.string :title
      t.text :token

      t.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
