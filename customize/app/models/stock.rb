class Stock < ActiveRecord::Base
  belongs_to :dish, class_name: "Dish", foreign_key: "dish_id"
  attr_accessible :dish, :date, :stock
end
