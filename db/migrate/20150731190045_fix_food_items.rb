class FixFoodItems < ActiveRecord::Migration
  def change
    add_column :list_items, :user_id, :integer
    add_column :list_items, :food_id, :integer
    remove_column :list_items, :users_id
    remove_column :list_items, :foods_id
  end
end
