class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date  , null: false       #予約受付日
      t.integer :member_id , null: false, default: @current_member.id     #会員ID
      t.datetime :receive_date, null: false  #受取日時
      t.integer :lunchbox_id, null: false     #弁当箱ID
      t.integer :staple_id, null: false       #主食ID
      t.integer :main_id, null: false         #主菜ID
      t.integer :sub_id, null: false          #副菜ID
      t.integer :num , null: false            #個数
      t.string :status         #状態
    end
  end
end
