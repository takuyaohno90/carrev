class Admin::HomesController < ApplicationController
  def top
    @caritems = CarItem.page(params[:page]).per(6)
  end

end
