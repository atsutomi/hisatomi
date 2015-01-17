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

  def show
    cookies[:dish] = params[:id]
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
    @dishes = Dish.search(params[:q])
    render "index"
  end

  def order
    @dish = Dish.find(cookies[:dish])
    case @dish.category
      when "staple"
        cookies[:staple] = @dish.id
      when "main"
        cookies[:main] = @dish.id
      when "sub"
        cookies[:sub] = @dish.id
    end
    redirect_to :controller =>"orders", :action =>"edit" 
  end

  private
  def send_image
    if @dish.image.present?
      send_data @dish.image.data,
        type: @dish.image.content_type, disposition: "inline"
    end
  end
end
