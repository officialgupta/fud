class ListItem < ActiveRecord::Base
  belongs_to :food

  def check_off
    Item.create(user: self.user,
                quantity: self.quantity,
                quantity_type: self.quantity_type,
                when_bought: Date.today,
                food: self.food)
    self.delete
  end
end
