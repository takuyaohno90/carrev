class User::HomesController < ApplicationController
  def top
    @car_items =  CarItem.order(created_at: :desc).limit(6)
    @sixth_car_item = @car_items[5]
  end

  def about
  end
end
