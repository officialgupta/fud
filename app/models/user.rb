class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :recipes
  has_many :list_items

  has_many :photos

  phony_normalize :phone, :default_country_code => 'UK'

  validates :first_name, :last_name, :presence => true

  geocoded_by :postcode

  after_validation :geocode

  def foodbanks_within(distance)
    Foodbank.within(distance, origin: [latitude, longitude])
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
   default_url = "http://img2.wikia.nocookie.net/__cb20130607025329/creepypasta/images/3/38/Avatar-blank.jpg"
   gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
   "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
 end

end
