class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :recipes
  has_many :list_items

  phony_normalize :phone, :default_country_code => 'UK'

  validates :first_name, :last_name, :presence => true

  geocoded_by :postcode

  after_validation :geocode
  before_save :set_score

  def foodbanks_within(distance)
    Foodbank.within(distance, origin: [latitude, longitude])
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_score
    user_score = self.items.disposed*(-10)
    user_score += self.items.used*10
    user_score += self.items.donated*5

    self.score = user_score
  end
end
