class RemoveDistaceIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :distance_id, :string
  end
end
