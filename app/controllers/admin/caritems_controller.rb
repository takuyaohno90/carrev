class Admin::CaritemsController < ApplicationController
  before_action :authenticate_admin!
  def check
  end

  def new
    @caritem = CarItem.new
  end

  def create
    @caritem = CarItem.new(caritem_params)
    @caritem_check = CarItem.find_by(name: params[:car_item][:name])
    if !@caritem_check
      if @caritem.save
        flash[:notice] = "車種登録に成功しました。"
        redirect_to caritem_path(@caritem.id)
      else
        flash[:alert] = "入力に誤りがあります。"
        render :new
      end
    else
      flash[:alert] = "既に登録済みの車種です。"
      render :new
    end
  end


  def show
    @caritem = CarItem.find(params[:id])
  end

  def edit
    @caritem = CarItem.find(params[:id])
  end

  def update
    @caritem = CarItem.find(params[:id])
    if @caritem.update(caritem_params)
      flash[:notice] = "車種登録情報の編集に成功しました。"
      redirect_to caritem_path(@caritem.id)
    else
      flash[:alert] = "車種登録情報の編集に失敗しました。"
      render :edit
    end

  end

  def destroy
    @caritem = CarItem.find(params[:id])
    @caritem.destroy
    @caritems = CarItem.all
    flash[:notice] = "車種登録情報の削除に成功しました。"
    redirect_to admin_path
  end

  def caritem_params
    params.require(:car_item).permit(:maker_id, :fuel_id, :bodytype_id, :name, :num_people, :displacement, :drive_system, :door, :mission, :model_year, :fuel_consumption, :weight, :size, :car_image)
  end

end
