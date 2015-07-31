class FoodbanksController < ApplicationController
  def find
    @distance = params[:distance] || 10
    @home = true unless params[:lat] && params[:lng]
    @url = find_foodbanks_path
    @latitude = params[:lat] unless @home
    @longitude = params[:lng] unless @home

    if @home
      @loc = [current_user.latitude, current_user.longitude]
    else
      @loc = [@latitude.to_f, @longitude.to_f]
    end

    @foodbanks = Foodbank.within(@distance, origin: @loc).sort_by{|f| f.distance_to(@loc)}

    client = ::Uber::Client.new do |config|
      config.server_token  = "ZN5dZ9KK0SeBdFpc2Hg0pRPWCDgtBF9JbajeIS5-"
    end

    puts ">>>>>>>>>>>>>>>>>>>>>>>"
    puts @loc[0]
    puts @loc[1]


    @uber_prices = @foodbanks.inject({}) do |hash, foodbank|
      puts foodbank.latitude
      puts foodbank.longitude
      hash[foodbank.id] = client.price_estimations(start_latitude: @loc[0], start_longitude: @loc[1],
                           end_latitude: foodbank.latitude, end_longitude: foodbank.longitude)
      hash
    end
  end

  def location
    @foodbank = Foodbank.find(params[:id])
  end
end
