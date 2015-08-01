class RecipesController < ApplicationController
  require 'httparty'
  require 'uri'
  def index
    if params[:ingredients].nil? && current_user.items.in_use.count != 0
      @ingredients = current_user.items.includes(:food).in_use.map(&:food)
    elsif !params[:ingredients].nil?
      @ingredients = params[:ingredients].map{|id| Food.find(id)}
    else
      @ingredients = []
    end

    @search_ingredients = @ingredients.map {|i| i.name.split.first}.join(",").encode('UTF-8', :invalid => :replace) || "tomato"
    @page = params[:page].to_i
    @page = 1 if @page == 0

    response = HTTParty.get("http://api.pearson.com:80/kitchen-manager/v1/recipes?ingredients-any=#{URI.encode(@search_ingredients)}&offset=#{(@page-1)*20}&limit=20")
    @response= response.body
    @recipes = JSON.parse(@response)["results"].map{|r| OpenStruct.new(r)}

    @pages = (response.parsed_response["total"]/20.0).ceil
  end

  def show
    response = HTTParty.get("https://api.pearson.com/kitchen-manager/v1/recipes/#{params[:id]}")
    @response= response.body
    @recipe = OpenStruct.new(JSON.parse(@response))
  end
end
