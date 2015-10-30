class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :report_date, :date
    add_column :users, :birthday, :date
    add_column :users, :gender_id, :integer
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :injury, :string
    add_column :users, :distance, :string
  end
end
