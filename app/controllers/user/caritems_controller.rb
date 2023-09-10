class User::CaritemsController < ApplicationController
  
  def index
    @caritems = CarItem.page(params[:page]).per(12)
  end
  
  def show
    @caritem = CarItem.find(params[:id])
  end

end
