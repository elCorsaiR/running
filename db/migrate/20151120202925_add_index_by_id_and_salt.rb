class AddIndexByIdAndSalt < ActiveRecord::Migration
  def change
    add_index :users, [:id, :solt]
  end
end
