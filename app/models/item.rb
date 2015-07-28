class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  validates :quantity_type, :quantity, :when_bought, :when_expire, :user_id, :food_id, uniqueness: true

  before_validation :set_when_expire

  def set_when_expire
    self.when_expire = self.when_bought + self.food.time_to_expire_in_days.days
  end

  def expired?
    Time.now > self.when_expire
  end

  def expired_in?(days)
    Time.now + days.days > self.when_expire
  end
end
