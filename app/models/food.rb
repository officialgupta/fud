class Food < ActiveRecord::Base
  # require 'flickr_fu'
  has_many :items
  has_many :list_items

  has_and_belongs_to_many :recipes

  validates :name, uniqueness: true

  validates :name, :food_type, :where_stored, :time_to_expire_in_days, presence: true

  before_validation :set_image_url

  def set_image_url
    # puts "#{Rails.root}/config/flickr.yml"
    # flickr = Flickr.new("#{Rails.root}/config/flickr.yml", content_type: 1, media: "photo")
    # photos = flickr.photos.search(:tags => name.downcase.gsub(" ", "+"))
    # self.image_url = photos.first.url(:medium) unless photos.first.nil?

    data = JSON.parse(open("https://api.datamarket.azure.com/Bing/Search/v1/Image?$format=json&Query=%27#{CGI.escape(name + " photo")}%27", :http_basic_authentication=>["8g4bf1KG8MEmBTM1JMnPv47TbemHVjJrhLfG6ZnOFcU", "8g4bf1KG8MEmBTM1JMnPv47TbemHVjJrhLfG6ZnOFcU"]).read)
    if data["d"]["results"][0]
      url = data["d"]["results"][0]["MediaUrl"]
    else
      url = "http://suckhoevang.net/wp-content/uploads/che_do_an_theo_nhom_mau.jpg"
    end
    x = 1
    while url.length >= 255
      url = data["d"]["results"][x]["MediaUrl"]
      x += 1
    end
    self.image_url = url
  end

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

  def self.from_image(image_path)
    image = RTesseract.new(image_path)
    text = Spell.correct_para(image.to_s)
    if text.present?
      self.search(text)
    else
      nil
    end
  end
end
