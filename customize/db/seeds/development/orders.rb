#coding: utf-8

status = ["仮予約", "本予約", "済"]

0.upto(30) do |i|
  @order = Order.create(order_date: Date.today,
               member_id: i%3+1,
               receive_date: DateTime.now + i,
               lunchbox_id: i%3 + 1,
               staple_id: [1,4].sample,
               main_id: [2,5].sample,
               sub_id: [3,6].sample,
               num: i%4+1,
               status: status[i%3]
               )
  select3 = [@order.staple_id, @order.main_id, @order.sub_id]
  select3.each do |sel|
    dishes = Dish.find(sel+1)
    dishes.orders << @order
  end
end
