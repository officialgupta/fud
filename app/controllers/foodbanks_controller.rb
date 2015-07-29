class FoodbanksController < ApplicationController
  def find
    @distance = params[:distance] || 10
    @home = true unless params[:lat] && params[:lng]
    @url = foodbanks_find_url
    @latitude = params[:lat] unless @home
    @longitude = params[:lng] unless @home

    if @home
      @loc = [current_user.latitude, current_user.longitude]
    else
      @loc = [@latitude.to_f, @longitude.to_f]
    end

    @foodbanks = Foodbank.within(@distance, origin: @loc).sort_by{|f| f.distance_to(@loc)}
  end
end