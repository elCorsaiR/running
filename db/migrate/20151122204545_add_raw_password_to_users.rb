class AddRawPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :raw_password, :string
  end
end
