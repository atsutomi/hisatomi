#coding: utf-8
class OrdersController < ApplicationController
  before_filter :login_required
  #予約履歴一覧
  def index
    @orders = @current_member.orders.order("order_date")
  end

  #新規予約
  def new
    if params[:name] == nil
      session.delete(:order)
      @order = Order.new
      @order.member_id = @current_member.id
      @order.order_date = Date.today
      @order.status = "本予約"
      session[:order] = @order
    else
      @order = session[:order]
    end
    @lunchboxes = Lunchbox.all
    @size = Array.new
    @explanation = Array.new
    @lunchboxes.each do |lunchbox|
      @size.push([lunchbox.size, lunchbox.id])
      @explanation.push(lunchbox.explanation)
    end
  end

  #登録
  def create
    @order = Order.new(params[:order])
    select3 = [@order.staple_id, @order.main_id, @order.sub_id]
    select3.each do |sel|
      dishes = Dish.find(sel)
      dishes.orders << @order
    end
    @lunchbox = Lunchbox.find(@order.lunchbox_id)
    @order.lunchbox = @lunchbox
    @order.save
    session.delete(:order)
    session.delete(:status)
    @date=@order.receive_date.to_s.split(" ")[0]
    @order.dishes.each do |dish|
      @stock = Stock.where(dish_id: "#{dish.id}", date: "#{@date}")
      @stock[0].stock = @stock[0].stock - @order.lunchbox.capacity * @order.num
      @stock[0].save
    end
  end



  #予約履歴詳細
  def show
    @order = Order.find(params[:id])
  end

  #予約削除
  def destroy
  end

  #確認画面
  def check
    @order = Order.new(params[:order])
    session[:order]= @order
    if params[:changedate]
      @lunchboxes = Lunchbox.all
      @size = Array.new
      @explanation = Array.new
      @lunchboxes.each do |lunchbox|
        @size.push([lunchbox.size, lunchbox.id])
        @explanation.push(lunchbox.explanation)
      end
      render "new"
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
       @date = @order.receive_date.to_s.split(" ")[0]
       
       @max= 10000
       @staple_stock = Stock.where(dish_id: "#{@order.staple_id}", date: "#{@date}")
       @max = @staple_stock[0].stock if @max > @staple_stock[0].stock
       @main_stock =Stock.where(dish_id: "#{@order.main_id}", date: "#{@date}")
       @max = @main_stock[0].stock if @max > @main_stock[0].stock
       @sub_stock =Stock.where(dish_id: "#{@order.sub_id}", date: "#{@date}")
       @max = @sub_stock[0].stock if @max > @sub_stock[0].stock
       
       
       @max = @max - @lunchbox.capacity * @order.num
       if @max <= 50
        @order.status = "仮予約"
       end
       
       render  :action =>"check"
     else
       redirect_to :action =>"new", :name=>"select"
     end
    end
  end
  
end
