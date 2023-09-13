class StocksController < ApplicationController
  before_action :edit_check, only: :edit
  before_action :set_stock, only: [:edit, :update]

  def index
    stocks = Stock.includes(:user)
    @stocks = current_user.stocks
    @stocks.each do |stock|
      # 缶の重量1.14kg（一斗缶の重量JIS規格）を除く
      stock.remaining = (stock.remaining_in_can - 1.14).round(2)
      stock.applicable_area = (stock.remaining / stock.amount).round(2)
    end
  end
  
  def new
    @stock = Stock.new
    p_informations = PInformation.includes(:user)
    @p_informations = current_user.p_informations
  end

  def create
    @stock = Stock.new(stock_params)
    p_informations = PInformation.includes(:user)
    @p_informations = current_user.p_informations
    if @stock.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @stock.update(stock_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    stock = Stock.find(params[:id])
    stock.destroy
    redirect_to root_path
  end

  def search
    @stocks = Stock.search(params[:keyword], current_user.id)
    @stocks.each do |stock|
      # 缶の重量1.14kg（一斗缶の重量JIS規格）を除く
      stock.remaining = (stock.remaining_in_can - 1.14).round(2)
      stock.applicable_area = (stock.remaining / stock.amount).round(2)
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:p_name, :category_id, :color, :gloss, :remaining_in_can, :amount,
                                  :standard_id, :remarks).merge(user_id: current_user.id)
  end

  def edit_check
    @stock = Stock.find(params[:id])
    if @stock.user_id != current_user.id
      redirect_to root_path
    end
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end

end
