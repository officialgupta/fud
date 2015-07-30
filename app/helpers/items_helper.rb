module ItemsHelper
  def food_expiry_colour(expires_in)
    if expires_in <= 0
      "200,10,0"
    elsif expires_in < 7
      "255, 170, 34"
    else
      "120, 164, 37"
    end
  end
end
