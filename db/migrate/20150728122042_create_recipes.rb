class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :instructions
      t.integer :user_id
      t.string :url

      t.timestamps null: false
    end
  end
end
