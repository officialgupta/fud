class Foodbank < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def address
    "#{name}, #{county}, UK"
  end
end
