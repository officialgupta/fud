class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    respond_to do |format|
      if @photo.save
        format.html { redirect_to root_path, notice: 'Photo was successfully uploaded.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
