class AddLatitudeAndLongitudeToFoodbank < ActiveRecord::Migration
  def change
    add_column :foodbanks, :latitude, :float
    add_column :foodbanks, :longitude, :float
  end
end
