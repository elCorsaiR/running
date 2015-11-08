class ChangePerColumnsToInt < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :left_stride_time_swing_per, :integer
      t.change :right_stride_time_swing_per, :integer
    end
  end
end
