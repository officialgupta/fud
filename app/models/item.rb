class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  before_validation :set_when_expire

  def set_when_expire
    self.when_expire = self.when_bought + self.food.time_to_expire_in_days.days
  end
end
