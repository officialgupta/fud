class ScansController < ApplicationController

  def scan
    Item.create!(:food_id => Food.from_ean(sms_params[:content].tr('/', '')).id, :quantity => 1, :quantity_type => "units", :when_bought => Date.today, :user_id => current_user.id)
    redirect_to root_path, notice: 'Item was successfully scanned.'
  end

  private

  def sms_params
    params.permit(:content)
  end
end
