class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.text :recommendation
      t.integer :order_no
    end
  end
end
