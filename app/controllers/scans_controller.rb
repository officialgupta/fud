class ScansController < ApplicationController

  def scan

  end

  private

  def sms_params
    params.require(:scans).permit(:content)
  end
end
