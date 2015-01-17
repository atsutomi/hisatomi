class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :id, :order_date, :member_id, :receive_date, :lunchbox_id, :staple_id, :main_id, :sub_id, :num, :status
  belongs_to :member, foreign_key: "member_id"
  belongs_to :lunchbox
  has_many :customs
  has_many :dishes, through: :customs

  validates :staple_id, :main_id, :sub_id, presence:true
end
