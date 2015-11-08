class CreateFootAndKneeAngels < ActiveRecord::Migration
  def change
    create_table :foot_and_knee_angels do |t|
      t.integer :user_id, index: true
      t.integer :position, index: true
      t.float :left_foot_angle
      t.float :right_foot_angle
      t.float :left_knee_angle
      t.float :right_knee_angle
    end
  end
end
