class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
    end

    add_index :sports, :name, unique: true
  end
end
