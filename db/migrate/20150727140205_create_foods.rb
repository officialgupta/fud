class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.string :food_type
      t.integer :time_to_expire_in_days

      t.timestamps null: false
    end
  end
end
