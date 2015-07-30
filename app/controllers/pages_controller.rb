class PagesController < ApplicationController
  def index

  end

  def show
    @user = User.first
    render "pages/#{params[:name]}"
  end
end
