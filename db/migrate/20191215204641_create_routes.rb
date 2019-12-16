class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.string :from
      t.string :to
      t.string :token
      t.timestamps
    end
  end
end
