class PagesController < ApplicationController
  def index

  end

  def show
    @user = User.first
    if params[:name] == "digest_design"
      render "pages/#{params[:name]}", layout: false
    else
      render "pages/#{params[:name]}"
    end
  end
end
