class AddSpeedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kmh, :string
    add_column :users, :minkm, :string
  end
end
