class AddFields2ToUser < ActiveRecord::Migration
  def change
    add_column :users, :max_pronation_left, :integer
    add_column :users, :max_pronation_right, :integer

    add_column :users, :pronation_speed_left, :integer
    add_column :users, :pronation_speed_right, :integer

    add_column :users, :tibia_max_rotation_left, :integer
    add_column :users, :tibia_max_rotation_right, :integer

    add_column :users, :tibia_rotation_left, :integer
    add_column :users, :tibia_rotation_right, :integer
  end
end
