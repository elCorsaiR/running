class CreateKneeFrontalAngles < ActiveRecord::Migration
  def change
    create_table :knee_frontal_angles do |t|
      t.integer :user_id, index: true
      t.integer :position, index: true
      t.float :left
      t.float :right
    end
  end
end
