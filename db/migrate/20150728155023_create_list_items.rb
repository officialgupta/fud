class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.references :foods
      t.references :users
      t.decimal :quantity
      t.string :quantity_type
      t.timestamps null: false
    end
  end
end
