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

  def uber_price loc
    client = ::Uber::Client.new do |config|
      config.server_token  = "ZN5dZ9KK0SeBdFpc2Hg0pRPWCDgtBF9JbajeIS5-"
    end

    client.price_estimations(start_latitude: loc[0], start_longitude: loc[1],
                         end_latitude: self.latitude, end_longitude: self.longitude)
  end

end
