class AddImageColumnToPhotos < ActiveRecord::Migration
  def up
    add_attachment :photos, :image
  end

  def down
    remove_attachment :photos, :image
  end
end
