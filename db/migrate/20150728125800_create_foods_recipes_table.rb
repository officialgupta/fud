class CreateFoodsRecipesTable < ActiveRecord::Migration
  def change
    create_table :foods_recipes do |t|
      t.references :food
      t.references :recipe
    end
  end
end
