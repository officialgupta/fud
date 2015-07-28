class AddWhereStoredToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :where_stored, :string
  end
end
