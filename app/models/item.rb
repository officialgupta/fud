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

  def self.sms(content, number)
    user = User.select{|u| u.phone = "+#{number}"}.first
    items = user.items.select{|i| i.expired_in?(3)}
    content.split(" ").each do |c|
      if c.match(/(\S+)[:](\S+)/)
        item = items.select {|i| i.food.name == c.match(/(\S+)[:](\S+)/)[1]}.first
        item.status = c.match(/(\S+)[:](\S+)/)[2]
        item.save
      end
    end
  end
end
