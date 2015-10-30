class AddIndexFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :ankle, :integer
    add_column :users, :knee, :integer
    add_column :users, :hip, :integer
    add_column :users, :functionality, :integer
    add_column :users, :total, :integer
  end
end
