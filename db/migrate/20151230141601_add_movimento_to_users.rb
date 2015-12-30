class AddMovimentoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :movimento_left, :integer
    add_column :users, :movimento_right, :integer
  end
end
