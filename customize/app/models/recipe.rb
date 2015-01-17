class Recipe < ActiveRecord::Base
  attr_accessible :dish_id, :foodstuff_id
  belongs_to :dish
  belongs_to :foodstuff
end
