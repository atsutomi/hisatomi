# coding: utf-8
class Admin::OrdersController < Admin::Base
  def index
    now_t = Date.today
    now_new_t = Time.local(now_t.year, now_t.month, now_t.day, 0, 0, 0).strftime("%Y-%m-%d %H:%M:%S")
    now_end_t = Time.local(now_t.year, now_t.month, now_t.day, 23, 59, 59).strftime("%Y-%m-%d %H:%M:%S")
    @today_order = Order.order("receive_date").find(:all, :conditions => ["receive_date > ? and receive_date < ?", now_new_t.to_s, now_end_t.to_s])
    @size = Array.new
    @staple = Array.new
    @main = Array.new
    @sub = Array.new
    @today_order.each do |order|
      case order.lunchbox_id
      when 1
        @size.push("大")
      when 2
        @size.push("普通")
      when 3
        @size.push("小")
      end
      @staple.push(Dish.find(order.staple_id).name)
      @main.push(Dish.find(order.main_id).name)
      @sub.push(Dish.find(order.sub_id).name)
    end

    @future_order = Order.paginate(
      :conditions => ["receive_date > ?", now_end_t.to_s],
      :page => params[:page],
      :order => 'receive_date',
      :per_page => 10
    )
    @a_size = Array.new
    @a_staple = Array.new
    @a_main = Array.new
    @a_sub = Array.new
    @future_order.each do |order|
      case order.lunchbox_id
      when 1
        @a_size.push("大")
      when 2
        @a_size.push("普通")
      when 3
        @a_size.push("小")
      end
      @a_staple.push(Dish.find(order.staple_id).name)
      @a_main.push(Dish.find(order.main_id).name)
      @a_sub.push(Dish.find(order.sub_id).name)
    end
  end

  def all_order
    @all_order = Order.paginate(
      :page => params[:page],
      :order => 'receive_date',
      :per_page => 10
    )
    @size = Array.new
    @staple = Array.new
    @main = Array.new
    @sub = Array.new
    @all_order.each do |order|
      case order.lunchbox_id
      when 1
        @size.push("大")
      when 2
        @size.push("普通")
      when 3
        @size.push("小")
      end
      @staple.push(Dish.find(order.staple_id).name)
      @main.push(Dish.find(order.main_id).name)
      @sub.push(Dish.find(order.sub_id).name)
    end
  end

  def show
    @order = Order.find(params[:id])
    session[:staple] = Order.find(params[:id]).staple_id
    session[:main] = Order.find(params[:id]).main_id
    session[:sub] = Order.find(params[:id]).sub_id
    @price = 0
    @kcal = 0
    @staple = Dish.find(@order.staple_id)
    @price += @staple.yen
    @kcal += @staple.kcal
    @main = Dish.find(@order.main_id)
    @price += @main.yen
    @kcal += @main.kcal
    @sub = Dish.find(@order.sub_id)
    @price += @sub.yen
    @kcal += @sub.kcal
    @size = Array.new
    @lunchbox = Lunchbox.find(@order.lunchbox_id)
    @price *= @order.lunchbox.capacity
    @kcal *= @order.lunchbox.capacity
  end

  def edit
    if params[:name] == "select"
      @order = session[:order]
    else
      @order = Order.find(params[:id])
      session[:old_order] = @order
      session[:order_id] = @order.id
    end
    
    @lunchboxes = Lunchbox.all
    @size = Array.new
    @explanation = Array.new
    @lunchboxes.each do |lunchbox|
      @size.push([lunchbox.size, lunchbox.id])
      @explanation.push(lunchbox.explanation)
    end
  end

  def check
    @order = Order.find(params[:id])
    @order.assign_attributes(params[:order])
    session[:order] = @order
    if params[:changedate]
      collect_info
      render "edit"
    elsif params[:staple]
      session[:status] = :staple
      redirect_to :controller=>"dishes", :action=>"index"
    elsif params[:main]
      session[:status] = :main
      redirect_to :controller=>"dishes", :action=>"index"
    elsif params[:sub]
      session[:status] = :sub
      redirect_to :controller=>"dishes", :action=>"index"
    else
     if @order.valid?
       @lunchbox = Lunchbox.find(@order.lunchbox_id)
       @staple = Dish.find(@order.staple_id)
       @main = Dish.find(@order.main_id)
       @sub = Dish.find(@order.sub_id)
       @price = (@staple.yen + @main.yen + @sub.yen) * @lunchbox.capacity
       @kcal = (@staple.kcal + @main.kcal + @sub.kcal) * @lunchbox.capacity
       @sum = @price * @order.num
       render  :action =>"check"
     else
       redirect_to :action =>"edit"
     end
    end
  end

  def update
    @order = Order.find(session[:order_id])
    @order.assign_attributes(params[:order])
    @order.save
        
    @lunchbox = Lunchbox.find(@order.lunchbox_id)
    @order.lunchbox = @lunchbox

    @old_date = session[:old_order].receive_date.to_s.split(" ")[0]
    session[:order].dishes.each do |dish|
      @stock = Stock.where(dish_id: "#{dish.id}", date: "#{@old_date}")
      @stock[0].stock = @stock[0].stock + @order.lunchbox.capacity * @order.num
      @stock[0].save
    end
    Custom.destroy_all(order_id: @order.id)
    select3 = [@order.staple_id, @order.main_id, @order.sub_id]
    select3.each do |sel|
      dishes = Dish.find(sel)
      dishes.orders << @order
    end
    
    session.delete(:order)
    session.delete(:status)
    
    @date=@order.receive_date.to_s.split(" ")[0]
    @order.dishes.each do |dish|
      @stock = Stock.where(dish_id: "#{dish.id}", date: "#{@date}")
      @stock[0].stock = @stock[0].stock - @order.lunchbox.capacity * @order.num
      @stock[0].save
    end
    render :action => "update", notice: "予約情報を更新しました。"
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to :admin_orders, notice: "予約情報を削除しました。"
  end
  
  private
  def collect_info
    @lunchboxes = Lunchbox.all
    @size = Array.new
    @explanation = Array.new
    @lunchboxes.each do |lunchbox|
      @size.push([lunchbox.size, lunchbox.id])
      @explanation.push(lunchbox.explanation)
    end
  end
end
