class AddStatusAndWhereStoredToItems < ActiveRecord::Migration
  def change
    add_column :items, :status, :string
    add_column :items, :where_stored, :string
  end
end
