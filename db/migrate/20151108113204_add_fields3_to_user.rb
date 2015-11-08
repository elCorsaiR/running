class AddFields3ToUser < ActiveRecord::Migration
  def change
    add_column :users, :left_stride_time, :float
    add_column :users, :left_stride_time_stance, :float
    add_column :users, :left_stride_time_stance_per, :integer
    add_column :users, :left_stride_time_swing, :float
    add_column :users, :left_stride_time_swing_per, :float
    add_column :users, :right_stride_time, :float
    add_column :users, :right_stride_time_stance, :float
    add_column :users, :right_stride_time_stance_per, :integer
    add_column :users, :right_stride_time_swing, :float
    add_column :users, :right_stride_time_swing_per, :float

    add_column :users, :stride_time, :float
    add_column :users, :left_stride_time_per, :integer
    add_column :users, :right_stride_time_per, :integer

    add_column :users, :stride_length, :float
    add_column :users, :left_stride_length, :float
    add_column :users, :left_stride_length_per, :integer
    add_column :users, :right_stride_length, :float
    add_column :users, :right_stride_length_per, :integer

    add_column :users, :stride_frequency, :integer
    add_column :users, :left_stride_frequency, :integer
    add_column :users, :left_stride_frequency_per, :integer    
    add_column :users, :right_stride_frequency, :integer
    add_column :users, :right_stride_frequency_per, :integer

    add_column :users, :left_stride_frequency_evaluation, :integer
    add_column :users, :right_stride_frequency_evaluation, :integer

    add_column :users, :width_between_left_stances_evaluation, :integer
    add_column :users, :width_between_right_stances_evaluation, :integer

    add_column :users, :tip_direction_of_left_foot_evaluation, :integer
    add_column :users, :tip_direction_of_right_foot_evaluation, :integer
  end
end
