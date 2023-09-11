class StocksController < ApplicationController

  def index
  end
  
  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:p_name, :category_id, :color, :gloss, :remaining_in_can, :amount,
                                  :standard_id, :remarks).merge(user_id: current_user.id)
  end

end
