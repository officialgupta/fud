class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all.map{|u| u.full_name}.to_s.html_safe
  end

  def points
    @user = User.select{|u| u.full_name == params[:name]}.first
    render plain: @user.score
  end
end
