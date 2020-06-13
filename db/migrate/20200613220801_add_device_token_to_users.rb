class AddDeviceTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :device_token, :string
  end
end
