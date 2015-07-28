class Food < ActiveRecord::Base
  has_many :items

  has_and_belongs_to_many :recipes

  validates :name, uniqueness: true

  validates :name, :food_type, :where_stored, :time_to_expire_in_days, presence: true

  def self.search(words)
    foods = Set.new

    words.split(" ").each do |keyword|
      foods << where(['lower(name) LIKE ?', "%#{keyword.downcase}%"])
      foods << where(['lower(food_type) LIKE ?', "%#{keyword.downcase}%"])
    end
    foods = foods.first
    dups = foods.group_by {|e| e}.select { |k,v| v.size > 1}.keys
    foods -= dups
    dups + foods
  end

  def self.from_ean(ean)
    auth = {:username => "fe1f040131f9f3503d5afe14137ad067", :password => "test"}
    response = HTTParty.get("https://api.outpan.com/v1/products/#{ean}", :basic_auth => auth)
    self.search(response["name"]).first
  end
end
