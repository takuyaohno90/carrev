class Admin::FuelsController < ApplicationController

  def index
    @fuel = Fuel.new
    @fuels = Fuel.all
  end

  def create
    @fuel = Fuel.new(fuel_params)
    if @fuel.save
      redirect_to fuels_path
    else
      render :new
    end
  end

  def edit
    @fuel = Fuel.find(params[:id])
  end

  def update
    @fuel = Fuel.find(params[:id])
    if @fuel.update(fuel_params)
      redirect_to fuels_path
    else
      render :edit
    end
  end

  def destroy
    @fuel = Fuel.find(params[:id])
    @fuel.destroy
    redirect_to fuels_path
  end

  private

  def fuel_params
    params.require(:fuel).permit(:name)
  end

end
