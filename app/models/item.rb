class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  validates :quantity_type, :quantity, :when_bought, :when_expire, :user_id, :food_id, presence: true
  validates :status, inclusion: {in: ["in-use", "disposed", "donating", "donated", "used"]}

  before_validation :defaults, :set_when_expire, :set_where_stored
  after_create :update_user_score

  scope :pantry, -> { where("(where_stored= 'Pantry') AND (status = 'in-use')").order('when_expire ASC') }
  scope :fridge, -> { where("(where_stored= 'Fridge') AND (status = 'in-use')").order('when_expire ASC')}
  scope :freezer, -> { where("(where_stored= 'Freezer') AND (status = 'in-use')").order('when_expire ASC')}
  scope :in_use, -> { where("status = 'in-use'") }
  scope :donating, -> { where("status = 'donating'") }
  scope :donated, -> { where("status = 'donated'") }
  scope :used, -> { where("status = 'used'") }
  scope :disposed, -> { where("status = 'disposed'") }

  def set_when_expire
    self.when_expire = self.when_bought + self.food.time_to_expire_in_days.days if self.food.present?
  end

  def set_where_stored
    self.where_stored = self.food.where_stored if self.food.present?
  end

  def expired?
    Time.now > self.when_expire
  end

  def expired_in?(days)
    !self.expired? && expired_by?(days)
  end

  def expired_by?(days)
    Time.now + days.days > self.when_expire
  end

  def expires_in
    (self.when_expire - Date.today).to_i
  end

  def self.sms(content, number)
    user = User.where(['phone LIKE ?', "%#{number}%"]).first
    items = user.items.select{|i| i.expired_in?(3)}
    content.split(" ").each do |c|
      if c.match(/(\S+)[:](\S+)/)
        item = items.select {|i| i.food.name == c.match(/['](.+)['][:]['](.+)[']/)[1]}.first
        item.status = c.match(/(\S+)[:](\S+)/)[2]
        item.save
      end
    end
  end

  def self.create_from_user_photo(user_id, photo_path)
    foods = Food.from_image(photo_path)
    if foods.present?
      foods.each do |food|
        Item.create!(:food_id => food.id, :quantity => 1, :quantity_type => "units", :when_bought => Date.today, :user_id => user_id)
      end
    end
  end

  def defaults
    self.status ||= "in-use"
    self.when_bought ||= Date.today
  end

  def update_user_score
    self.user.save
  end
end
