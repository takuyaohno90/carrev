class User::CarSearchesController < ApplicationController

  def new
    @tag = Tag.all
    @bodytype = Bodytype.all
    @fuel = Fuel.all
    @discerning = ["デザイン", "走行性能", "燃費", "静粛性", "振動", "室内スペース", "荷室スペース", "本体価格", "維持費", "安全機能", "運転支援機能"]
  end

  def result
    @car_items = CarItem.all
    num_people = params[:num_people]
    bodytype_id = params[:bodytype_id]
    fuel_id = params[:fuel_id]
    if num_people.present? && num_people == "6"
      @car_items = @car_items.where("num_people >= 6")
    else
      @car_items = @car_items.where(num_people: num_people)
    end
    # デバッグ用
    # @car_items.each do |car_item|
      # puts "ID: #{car_item.id}, num_people: #{car_item.num_people}"
    # end
    #byebug

    if bodytype_id.present?
      @car_items_bodytype_id = @car_items.where(bodytype_id: bodytype_id)
      if @car_items_bodytype_id.present?
        @car_items = @car_items_bodytype_id
      end
    end

    if fuel_id.present?
      @car_items_fuel_id = @car_items.where(fuel_id: fuel_id)
      if @car_items_fuel_id.present?
        @car_items = @car_items_fuel_id
      end
    end


  end
end
