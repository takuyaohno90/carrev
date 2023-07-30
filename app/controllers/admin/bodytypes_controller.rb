class Admin::BodytypesController < ApplicationController

  def index
    @bodytype = Bodytype.new
    @bodytypes = Bodytype.all
  end

  def create
    @bodytype = Bodytype.new(bodytype_params)
    if @bodytype.save
      redirect_to bodytypes_path
    else
      @bodytypes = Bodytype.all
      render :index
    end
  end

  def edit
    @bodytype = Bodytype.find(params[:id])
  end

  def update
    @bodytype = Bodytype.find(params[:id])
    if @bodytype.update(bodytype_params)
      redirect_to bodytypes_path
    else
      render :edit
    end
  end

  def destroy
    @bodytype = Bodytype.find(params[:id])
    @bodytype.destroy
    redirect_to bodytypes_path
  end

  private

  def bodytype_params
    params.require(:bodytype).permit(:name)
  end

end
