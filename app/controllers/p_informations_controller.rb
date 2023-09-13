class PInformationsController < ApplicationController

  def new
    @p_information = PInformation.new
  end

  def create
    @p_information = PInformation.new(p_information_params)
    if @p_information.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @p_information = PInformation.find(params[:id])
    respond_to do |format|
      format.json { render json: @p_information }
    end
  end

  private

  def p_information_params
    params.require(:p_information).permit(:p_name, :category_id,:amount, :standard_id).merge(user_id: current_user.id)
  end

end
