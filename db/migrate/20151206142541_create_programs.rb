class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :user_id
      t.string :video_url
      t.integer :order_num
      t.string :text
    end
  end
end
