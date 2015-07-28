class Recipe < ActiveRecord::Base
  validates :name, uniqueness: true
  has_and_belongs_to_many :foods
  belongs_to :user
end
