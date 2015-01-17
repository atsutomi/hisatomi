class Lunchbox < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :size, :capacity, :explanation
  has_many :orders
end
