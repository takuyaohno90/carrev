class Admin::CaritemsController < ApplicationController
  def check
  end

  def new
    @caritem = CarItem.new
  end

  def create
    @caritem = CarItem.new(caritem_params)
    @caritem_check = CarItem.find_by(name: params[:car_item][:name])
    if !@caritem_check
      @caritem.save
      redirect_to caritem_path(@caritem.id)
    else
      flash[:notice] = "既に登録済みの車種です。"
      render :new
    end
  end


  def show
    @caritems = CarItem.find(params[:id])
  end

  def edit
  end

  def caritem_params
    params.require(:car_item).permit(:maker_id, :fuel_id, :bodytype_id, :name, :num_people, :displacement, :drive_system, :door, :mission, :model_year, :fuel_consumption, :weight, :size)
  end

end
