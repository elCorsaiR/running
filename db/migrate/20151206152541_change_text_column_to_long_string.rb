class ChangeTextColumnToLongString < ActiveRecord::Migration
  def change
    change_column :programs, :text, :text
  end
end
