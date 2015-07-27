class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :quantity
      t.string :quantity_type
      t.date :when_bought
      t.date :when_expire
      t.integer :user_id
      t.integer :food_id

      t.timestamps null: false
    end
  end
end
