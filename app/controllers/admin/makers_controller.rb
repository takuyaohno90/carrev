class Admin::MakersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @maker = Maker.new
    @makers = Maker.all
  end

  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      flash[:notice] = "メーカーの登録に成功しました。"
      redirect_to makers_path
    else
      @makers = Maker.all
      flash[:alert] = "メーカーの登録に失敗しました。"
      render :index
    end
  end

  def edit
    @maker = Maker.find(params[:id])
  end

  def update
    @maker = Maker.find(params[:id])
    if @maker.update(maker_params)
      flash[:notice] = "メーカーの編集に成功しました。"
      redirect_to makers_path
    else
      flash[:alert] = "メーカーの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @maker = Maker.find(params[:id])
    @maker.destroy
    flash[:notice] = "メーカーの削除に成功しました。"
    redirect_to makers_path
  end

  private

  def maker_params
    params.require(:maker).permit(:name)
  end



end
