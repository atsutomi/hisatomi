class Stock < ActiveRecord::Base
  belongs_to :dish, class_name: "Dish", foreign_key: "dish_id"
  attr_accessible :dish, :date, :stock
  
  validates :stock, numericality: { :greater_than_or_equal_to => 0 }
end
