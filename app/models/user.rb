class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items

  phony_normalize :phone, :default_country_code => 'UK'

  validates :phone, :phony_plausible => true

  validates :email, :postcode, :phone, :presence => true
end
