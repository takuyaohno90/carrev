class Admin::BodytypesController < ApplicationController
  def new
    @bodytype = Bodytype.new
  end

  def create
    @bodytype = Bodytype.new(bodytype_params)
    if @bodytype.save
      redirect_to bodytype_path(@bodytype.id)
    else
      render :new
    end
  end

  def index
  end

  def show
    @bodytype = Bodytype.find(params[:id])
  end

  def edit
  end

  private

  def bodytype_params
    params.require(:bodytype).permit(:name)
  end

end
