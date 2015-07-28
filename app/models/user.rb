class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items

  geocoded_by :postcode

  after_validation :geocode

  def foodbanks_within(distance)
    Foodbank.within(distance, origin: [latitude, longitude])
  end
end
