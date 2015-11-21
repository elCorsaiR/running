class AddSoltToUser < ActiveRecord::Migration
  def change
    add_column :users, :solt, :string
  end
end
