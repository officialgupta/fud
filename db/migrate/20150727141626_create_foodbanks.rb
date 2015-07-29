class CreateFoodbanks < ActiveRecord::Migration
  def change
    create_table :foodbanks do |t|
      t.string :company
      t.string :county
      t.string :name
      t.string :contact
      t.timestamps null: false
    end
  end
end
