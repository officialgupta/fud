class Food < ActiveRecord::Base
  has_many :items

  validates :name, uniqueness: true

  validates :name, :food_type, :where_stored, :time_to_expire_in_days, presence: true

  def self.search(words)
    foods = Set.new

    words.split(" ").each do |keyword|
      foods << where(['lower(name) LIKE ?', "%#{keyword.downcase}%"])
      foods << where(['lower(food_type) LIKE ?', "%#{keyword.downcase}%"])
    end
    foods.first.uniq
  end
end
