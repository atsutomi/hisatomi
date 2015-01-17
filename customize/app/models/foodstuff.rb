class Foodstuff < ActiveRecord::Base
  attr_accessible :name
  has_many :recipes
  has_many :dishes, through: :recipes
end
