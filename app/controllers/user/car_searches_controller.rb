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
    @discening_a = params[:discerning][0]
    @discening_b = params[:discerning][1]
    discening_conv
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

    top_records = @car_items.select("*").select("(#{@discening_a} + #{@discening_b}) AS total_score").order("total_score DESC").limit(3)
    #top_records = @car_items.select('*, (design_car + performance_car) AS total_score').order('total_score DESC').limit(3)
    #unless top_records.present?
      sorted_car_items = @car_items.order(:created_at).limit(3)
      byebug
    #end

  end


  private

    def discening_conv
      discening_lists = {
      "デザイン" => :design_car,
      "走行性能" => :performance_car,
      "燃費" => :fuel_consumptionrev_car,
      "静粛性" => :quietness_car,
      "振動" => :vibration_car,
      "室内スペース" => :indoor_space_car,
      "荷室スペース" => :luggage_space_car,
      "本体価格" => :price_car,
      "維持費" => :maintenance_cost_car,
      "安全機能" => :safety_car,
      "運転支援機能" => :assistance_car
      }
      @discening_a = discening_lists[@discening_a]
      @discening_b = discening_lists[@discening_b]
    end
end
