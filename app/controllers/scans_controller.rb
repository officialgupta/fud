class ScansController < ApplicationController

  def scan
    Item.create!(:food_id => Food.from_ean(sms_params[:content]).id, :quantity => 1, :quantity_type => "units", :when_bought => Date.today, :user_id => user_id)
  end

  private

  def sms_params
    params.require(:scans).permit(:content)
  end
end
