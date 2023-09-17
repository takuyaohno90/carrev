class Admin::FuelsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @fuel = Fuel.new
    @fuels = Fuel.all
  end

  def create
    @fuel = Fuel.new(fuel_params)
    if @fuel.save
      flash[:notice] = "燃料種別の登録に成功しました。"
      redirect_to fuels_path
    else
      @fuels = Fuel.all
      flash[:alert] = "燃料種別の登録に失敗しました。"
      render :index
    end
  end

  def edit
    @fuel = Fuel.find(params[:id])
  end

  def update
    @fuel = Fuel.find(params[:id])
    if @fuel.update(fuel_params)
      flash[:notice] = "燃料種別の編集に成功しました。"
      redirect_to fuels_path
    else
      flash[:alert] = "燃料種別の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @fuel = Fuel.find(params[:id])
    @fuel.destroy
    flash[:notice] = "燃料種別の削除に成功しました。"
    redirect_to fuels_path
  end

  private

  def fuel_params
    params.require(:fuel).permit(:name)
  end

end
