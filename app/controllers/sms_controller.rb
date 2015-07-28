class SmsController < ApplicationController
  def receiving
    Item.sms(params[:content], params[:number])
  end

  private

  def sms_params
    params.require(:sms).permit(:content, :number)
  end
end
