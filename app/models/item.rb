class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  validates :quantity_type, :quantity, :when_bought, :when_expire, :user_id, :food_id, presence: true

  before_validation :set_when_expire

  before_validation :set_where_stored

  def set_when_expire
    self.when_expire = self.when_bought + self.food.time_to_expire_in_days.days
  end

  def set_where_stored
    self.where_stored = self.food.where_stored
  end

  def expired?
    Time.now > self.when_expire
  end

  def expired_in?(days)
    Time.now + days.days > self.when_expire
  end

  def expires_in
    self.when_expire - Date.now 
  end
end
