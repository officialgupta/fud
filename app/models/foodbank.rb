class Foodbank < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def address
    "#{name}, #{county}, UK"
  end
end
