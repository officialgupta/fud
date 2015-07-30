class Foodbank < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def address
    regex = /[A-Z]+[0-9]+\s[0-9]+[A-Z]+/
    if regex.match(contact)
      postcode = ", #{regex.match(contact)[0]}"
    end
    "#{name}, #{county}, UK#{postcode}"
  end
end
