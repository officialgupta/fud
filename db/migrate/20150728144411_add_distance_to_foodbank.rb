class AddDistanceToFoodbank < ActiveRecord::Migration
  def change
    add_column :foodbanks, :distance, :float
  end
end
