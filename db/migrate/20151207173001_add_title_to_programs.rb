class AddTitleToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :title, :string
  end
end
