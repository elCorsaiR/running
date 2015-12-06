class AddConclusionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :conclusions, :text
  end
end
