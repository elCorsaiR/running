class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
    end

    add_index :levels, :name, unique: true
  end
end
