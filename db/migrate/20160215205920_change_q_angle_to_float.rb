class ChangeQAngleToFloat < ActiveRecord::Migration
  def change
    change_column :users, :q_angle_left, :float
    change_column :users, :q_angle_right, :float
  end
end
