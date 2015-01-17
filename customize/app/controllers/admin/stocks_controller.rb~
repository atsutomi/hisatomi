#coding:utf-8
class Admin::StocksController < Admin::Base
  def index
    @stocks = Stock.where("stock < '50'")
  end

  def index_all
    @stocks = Stock.select(:date).uniq
  end

  def show_date
    @date = params[:name].split(" ")[0]
    @stocks = Stock.find(:all, :conditions=>["date like ?", @date])
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    @stock.assign_attributes(params[:stock])
    if @stock.save
      redirect_to action: :index, notice: "在庫情報を更新しました。"
    else
      render "edit"
    end
  end

  def create
  end
end
