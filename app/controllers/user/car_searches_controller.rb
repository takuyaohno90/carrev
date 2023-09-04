class User::CarSearchesController < ApplicationController

  def new
    @bodytype = Bodytype.all
    @fuel = Fuel.all
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
    @discerning = ["デザイン", "走行性能", "燃費", "静粛性", "振動", "室内スペース", "荷室スペース", "本体価格", "維持費", "安全機能", "運転支援機能"]
  end

  def result
    @car_items = CarItem.all
    num_people = params[:num_people]
    bodytype_id = params[:bodytype_id]
    fuel_id = params[:fuel_id]

    # 人数で絞込
    if num_people.present? && num_people == "6"
      @car_items = @car_items.where("num_people >= 6")
    elsif num_people.present? && num_people != "6"
      @car_items = @car_items.where(num_people: num_people)
    else
      
    end
    # デバッグ用
    # @car_items.each do |car_item|
      # puts "ID: #{car_item.id}, num_people: #{car_item.num_people}"
    # end
    #byebug

    # ボディタイプで絞込
    if bodytype_id.present?
      @car_items_bodytype_id = @car_items.where(bodytype_id: bodytype_id)
      if @car_items_bodytype_id.present?  && @car_items_bodytype_id.size >= 3
        @car_items = @car_items_bodytype_id
      else
        
      end
    end

    # 燃料種別で絞込
    if fuel_id.present?
      @car_items_fuel_id = @car_items.where(fuel_id: fuel_id)
      if @car_items_fuel_id.present?  && @car_items_fuel_id.size >= 3
        @car_items = @car_items_fuel_id
      else
        render :failure
      end
    end

    # 評価項目で絞込
    discening_conv
    discening_conv_records = @car_items.select("*").select("(#{@discening_a} + #{@discening_b}) AS total_score").order("total_score DESC").limit(3)
    if discening_conv_records.present?  && discening_conv_records.size >= 3
      @car_items = discening_conv_records
    end

    # 使用シーン(タグ)で絞込
    tag_conv
    if @tag_a.present? && @tag_b.present?
      tag_conv_records = @car_items.select("*").select("(#{@tag_a} + #{@tag_b}) AS total_score").order("total_score DESC").limit(3)
      if tag_conv_records.present?  && tag_conv_records.size >= 3
        @car_items = tag_conv_records
      end
    end
    #top_records = @car_items.select('*, (design_car + performance_car) AS total_score').order('total_score DESC').limit(3)
    #unless top_records.present?
    #sorted_car_items = @car_items.order(:created_at).limit(3) 車種が見つからないときは登録日時で表示
    #end
  end


  private

    def tag_conv
      tag_lists = {
      "通勤通学" => :commuting_tag_count,
      "送迎" => :pick_up_tag_count,
      "買い物" => :shopping_tag_count,
      "スポーツ" => :sports_tag_count,
      "アウトドア" => :outdoor_tag_count,
      "オフロード" => :offroad_tag_count,
      "長距離" => :long_distance_tag_count,
      "走りを楽しむ" => :enjoy_tag_count
      }
      if params[:tags].present? && params[:tags].size >= 2
        @tag_a = params[:tags][0]
        @tag_b = params[:tags][1]
      elsif params[:tags].present? && params[:tags].size == 1
        @tag_a = params[:tags][0]
        @tag_b = params[:tags][0]
      end
      @tag_a = tag_lists[@tag_a]
      @tag_b = tag_lists[@tag_b]
    end

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
      "運転支援機能" => :assistance_car,
      "総合評価" => :evaluation_car
      }
      if params[:discerning].present? && params[:discerning].size >= 2
        @discening_a = params[:discerning][0]
        @discening_b = params[:discerning][1]
      elsif params[:discerning].present? && params[:discerning].size == 1
        @discening_a = params[:discerning][0]
        @discening_b = params[:discerning][0]
      else
        @discening_a = "総合評価"
        @discening_b = "総合評価"
      end
      @discening_a = discening_lists[@discening_a]
      @discening_b = discening_lists[@discening_b]
    end
end
