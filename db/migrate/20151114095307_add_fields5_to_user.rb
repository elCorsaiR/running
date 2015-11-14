class AddFields5ToUser < ActiveRecord::Migration
  def change
    add_column :users, :left_knee_abduction, :integer
    add_column :users, :right_knee_abduction, :integer
    add_column :users, :left_knee_abduction_speed, :integer
    add_column :users, :right_knee_abduction_speed, :integer
    add_column :users, :left_knee_rotation, :integer
    add_column :users, :right_knee_rotation, :integer
    add_column :users, :left_knee_flexion, :integer
    add_column :users, :right_knee_flexion, :integer
    add_column :users, :left_hip_abduction, :integer
    add_column :users, :right_hip_abduction, :integer
    add_column :users, :left_hip_basculation, :integer
    add_column :users, :right_hip_basculation, :integer
    add_column :users, :left_hip_rotation, :integer
    add_column :users, :right_hip_rotation, :integer
    add_column :users, :left_hip_max_extension, :integer
    add_column :users, :right_hip_max_extension, :integer

    add_column :users, :q_angle_left, :integer
    add_column :users, :q_angle_right, :integer

    add_column :users, :legs_length_discrepancy_left, :integer
    add_column :users, :back_foot_angle_left, :integer
    add_column :users, :back_tibial_strength_left, :integer
    add_column :users, :mid_gluteus_strength_left, :integer
    add_column :users, :isquiotibial_strength_left, :integer
    add_column :users, :vasto_intermedio_left, :integer
    add_column :users, :vasto_medial_left, :integer
    add_column :users, :vasto_lateral_left, :integer
    add_column :users, :psoas_iliaco_left, :integer
    add_column :users, :recto_femoral_left, :integer
    add_column :users, :isquiotibiales_left, :integer
    add_column :users, :iliotibial_band_left, :integer
    add_column :users, :hip_rotatoes_left, :integer
    add_column :users, :gastrocnemius_y_soleo_left, :integer

    add_column :users, :legs_length_discrepancy_right, :integer
    add_column :users, :back_foot_angle_right, :integer
    add_column :users, :back_tibial_strength_right, :integer
    add_column :users, :mid_gluteus_strength_right, :integer
    add_column :users, :isquiotibial_strength_right, :integer
    add_column :users, :vasto_intermedio_right, :integer
    add_column :users, :vasto_medial_right, :integer
    add_column :users, :vasto_lateral_right, :integer
    add_column :users, :psoas_iliaco_right, :integer
    add_column :users, :recto_femoral_right, :integer
    add_column :users, :isquiotibiales_right, :integer
    add_column :users, :iliotibial_band_right, :integer
    add_column :users, :hip_rotatoes_right, :integer
    add_column :users, :gastrocnemius_y_soleo_right, :integer
  end
end
