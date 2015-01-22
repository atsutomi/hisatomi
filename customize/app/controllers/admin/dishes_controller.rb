#coding : utf-8
class Admin::DishesController < Admin::Base
  def index    
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
  end

  def top
    session.delete(:status)
    session.delete(:order)
    session.delete(:order_id)
    session.delete(:old_order)
    @dishes = Dish.all
    if(session[:status] != nil)
      @dishes = Dish.where(category: session[:status])
    else
      @dishes = Dish.all
    end
    render "index"
  end

  def show
    @dish = Dish.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "admin/dishes/show"
    end
  end

  def new
    @dish = Dish.new
    @dish.build_image 
  end

  def create
    @dish = Dish.new(params[:dish])
    @stuffs_id = params[:stuffs]
    @stuff = Array.new
    @stuffs_id.each do |stuff_id|
        @stuff = Foodstuff.find(stuff_id)
        @stuff.dishes << @dish
    end
    if @dish.save
      0.upto(60) do |idx|
        Stock.create(
          dish: @dish,
          date: idx.days.from_now.to_date,
          stock: 100
        )	
      end
      redirect_to [:admin, @dish], notice: "料理を登録しました。"
    else
      render "new"
    end
  end

  def edit
    @dish = Dish.find(params[:id])
    @dish.build_image unless @dish.image
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.assign_attributes(params[:dish])
    if @dish.save
      redirect_to [:admin, @dish], notice: "料理の情報を更新しました。"
    else
      render "edit"
    end
      
  end

  def search
      @minus = params[:minus]
      @dishes = Dish.all
      if @minus
        @minus.each do |minus|
          @dishes.delete_if do |dish|
            @foodstuffs_name = Array.new
            dish.foodstuffs.each do |foodstuff|
              @foodstuffs_name.push(foodstuff.name.to_s)
            end
            @foodstuffs_name.include?(minus)
          end
        end
      else
        @dishes = Dish.search(params[:q])
      end
    render "index"
  end

  def order
    @dish = Dish.find(params[:id])
    case @dish.category
      when "staple"
        session[:order].staple_id = @dish.id
      when "main"
        session[:order].main_id = @dish.id
      when "sub"
        session[:order].sub_id = @dish.id
    end
    redirect_to :controller =>"orders", :action =>"edit" , :name=>"select"
  end

  private
  def send_image
    if @dish.image.present?
      send_data @dish.image.data,
        type: @dish.image.content_type, disposition: "inline"
    end
  end
end
