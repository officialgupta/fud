class RecipesController < ApplicationController
  require 'HTTParty'
  require 'uri'
  def index
    @ingredients = params[:ingredients]||current_user.items.in_use.map(&:food)
    @search_ingredients = @ingredients.map {|i| i.name.split.first}.join(",").encode('UTF-8', :invalid => :replace) || "tomato"
    @page = params[:page] || 1
    response = HTTParty.get("http://api.pearson.com:80/kitchen-manager/v1/recipes?ingredients-any=#{URI.encode(@search_ingredients)}&offset=#{(@page-1)*20}&limit=20")
    @recipes = response.parsed_response["results"].map{|r| OpenStruct.new(r)}
  end
end
