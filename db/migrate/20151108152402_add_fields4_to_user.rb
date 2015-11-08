class AddFields4ToUser < ActiveRecord::Migration
  def change
    add_column :users, :instant_of_left_max_pronation, :integer
    add_column :users, :instant_of_right_max_pronation, :integer
  end
end
