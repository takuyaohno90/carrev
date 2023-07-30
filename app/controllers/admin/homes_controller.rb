class Admin::HomesController < ApplicationController
  def top
    @caritems = CarItem.all
  end
  
end
