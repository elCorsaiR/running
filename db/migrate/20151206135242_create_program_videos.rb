class CreateProgramVideos < ActiveRecord::Migration
  def change
    create_table :program_videos do |t|
      t.integer :user_id
      t.string :video_url
    end
  end
end
