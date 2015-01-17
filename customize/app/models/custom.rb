class Custom < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :order_id, :dish_id
  belongs_to :order
  belongs_to :dish
end
