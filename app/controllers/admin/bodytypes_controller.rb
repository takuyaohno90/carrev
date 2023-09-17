class Admin::BodytypesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @bodytype = Bodytype.new
    @bodytypes = Bodytype.all
  end

  def create
    @bodytype = Bodytype.new(bodytype_params)
    if @bodytype.save
      flash[:notice] = "ボディタイプの登録に成功しました。"
      redirect_to bodytypes_path
    else
      @bodytypes = Bodytype.all
      flash[:alert] = "ボディタイプの登録に失敗しました。"
      render :index
    end
  end

  def edit
    @bodytype = Bodytype.find(params[:id])
  end

  def update
    @bodytype = Bodytype.find(params[:id])
    if @bodytype.update(bodytype_params)
      flash[:notice] = "ボディタイプの登録情報編集に成功しました。"
      redirect_to bodytypes_path
    else
      flash[:alert] = "ボディタイプの登録情報編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @bodytype = Bodytype.find(params[:id])
    @bodytype.destroy
    flash[:notice] = "ボディタイプの削除に成功しました。"
    redirect_to bodytypes_path
  end

  private

  def bodytype_params
    params.require(:bodytype).permit(:name)
  end

end
