class ScansController < ApplicationController

  def scan
    Item.create!(:food_id => Food.from_ean(sms_params[:content].tr('/', '')).id, :quantity => 1, :quantity_type => "units", :when_bought => Date.today, :user_id => user_id)
    puts Food.from_ean(sms_params[:content].tr('/', '')).name
  end

  private

  def sms_params
    params.permit(:content)
  end
end
