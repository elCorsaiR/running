class ChangeTypeToFloat < ActiveRecord::Migration
  def change
    change_column :users, :max_pronation_left, :float
    change_column :users, :max_pronation_right, :float

    change_column :users, :pronation_speed_left, :float
    change_column :users, :pronation_speed_right, :float

    change_column :users, :tibia_max_rotation_left, :float
    change_column :users, :tibia_max_rotation_right, :float

    change_column :users, :tibia_rotation_left, :float
    change_column :users, :tibia_rotation_right, :float

    change_column :users, :instant_of_left_max_pronation, :float
    change_column :users, :instant_of_right_max_pronation, :float

    change_column :users, :left_stride_frequency_evaluation, :float
    change_column :users, :right_stride_frequency_evaluation, :float
    change_column :users, :movimento_left, :float
    change_column :users, :movimento_right, :float
    change_column :users, :tip_direction_of_left_foot_evaluation, :float
    change_column :users, :tip_direction_of_right_foot_evaluation, :float
    change_column :users, :width_between_left_stances_evaluation, :float
    change_column :users, :width_between_right_stances_evaluation, :float


    change_column :users, :left_knee_abduction, :float
    change_column :users, :right_knee_abduction, :float
    change_column :users, :left_knee_abduction_speed, :float
    change_column :users, :right_knee_abduction_speed, :float
    change_column :users, :left_knee_rotation, :float
    change_column :users, :right_knee_rotation, :float
    change_column :users, :left_knee_flexion, :float
    change_column :users, :right_knee_flexion, :float
    change_column :users, :left_hip_abduction, :float
    change_column :users, :right_hip_abduction, :float
    change_column :users, :left_hip_basculation, :float
    change_column :users, :right_hip_basculation, :float
    change_column :users, :left_hip_rotation, :float
    change_column :users, :right_hip_rotation, :float
    change_column :users, :left_hip_max_extension, :float
    change_column :users, :right_hip_max_extension, :float

    change_column :users, :legs_length_discrepancy_left, :float
    change_column :users, :legs_length_discrepancy_right, :float
    change_column :users, :back_foot_angle_left, :float
    change_column :users, :back_foot_angle_right, :float

    change_column :users, :hip_rotatoes_left, :float
    change_column :users, :hip_rotatoes_right, :float
    change_column :users, :isquiotibiales_left, :float
    change_column :users, :isquiotibiales_right, :float
    change_column :users, :iliotibial_band_left, :float
    change_column :users, :iliotibial_band_right, :float

    change_column :users, :psoas_iliaco_left, :float
    change_column :users, :psoas_iliaco_right, :float
    change_column :users, :recto_femoral_left, :float
    change_column :users, :recto_femoral_right, :float
    change_column :users, :gastrocnemius_y_soleo_left, :float
    change_column :users, :gastrocnemius_y_soleo_right, :float

    change_column :users, :mid_gluteus_strength_left, :float
    change_column :users, :mid_gluteus_strength_right, :float
    change_column :users, :isquiotibial_strength_left, :float
    change_column :users, :isquiotibial_strength_right, :float
    change_column :users, :vasto_lateral_left, :float
    change_column :users, :vasto_lateral_right, :float

    change_column :users, :vasto_intermedio_left, :float
    change_column :users, :vasto_intermedio_right, :float
    change_column :users, :vasto_medial_left, :float
    change_column :users, :vasto_medial_right, :float
    change_column :users, :back_tibial_strength_left, :float
    change_column :users, :back_tibial_strength_right, :float
  end
end
