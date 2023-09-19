class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @review_tags = @review.tags
  end

  def edit
    @review = Review.find(params[:id])
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
  end

  def new_tag
    @review = Review.find(params[:id])
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
  end

  def create_tag
    @review = Review.find(params[:id])
    tag_list = params[:review][:name]
    @review.save_tag(tag_list)
    flash[:notice] = "レビューの編集に成功しました。"
    redirect_to review_path(@review.id)
  end

  def update
    @review = Review.find(params[:id])
    evaluation_cal_update
    if @review.update(review_params)
      evaluation_cal
      @review.save
      redirect_to new_tag_reviews_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    car_item_evaluation_cal_delete
    if @review.tags.present?
      tag_count_delete
    end
    @review.destroy
    flash[:notice] = "レビューの削除に成功しました。"
    redirect_to reviews_path
  end

    private

  def review_params
    params.require(:review).permit(:image, :title_rev, :favorite, :complain, :car_item_id, :design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance, :status)
  end

  def evaluation_cal
    total = @review.design + @review.performance + @review.fuel_consumptionrev + @review.quietness + @review.vibration + @review.indoor_space + @review.luggage_space + @review.price + @review.maintenance_cost + @review.safety + @review.assistance
    @review.evaluation = (total / 11.0).round(1)
  end

  def evaluation_cal_update
    total = params[:review][:design].to_i + params[:review][:performance].to_i + params[:review][:fuel_consumptionrev].to_i + params[:review][:quietness].to_i + params[:review][:vibration].to_i + params[:review][:indoor_space].to_i + params[:review][:luggage_space].to_i+ params[:review][:price].to_i + params[:review][:maintenance_cost].to_i + params[:review][:safety].to_i + params[:review][:assistance].to_i
    @review.evaluation = (total / 11.0).round(1)
  end
end

  def car_item_evaluation_cal_debug
   attributes = [
     :design_car, :performance_car, :fuel_consumptionrev_car, :quietness_car,
      :vibration_car, :indoor_space_car, :luggage_space_car, :price_car,
      :maintenance_cost_car, :safety_car, :assistance_car, :evaluation_car
    ]

    attributes.each do |attr|
      value = @review.car_item.send(attr)
     if value < 0 || value > 5
       @review.car_item.send("#{attr}=", 3.0)
     end
    end

    if @review.car_item.review_count < 0
      @review.car_item.review_count = 0
    end
  end

  def car_item_evaluation_cal_delete
    count = @review.car_item.review_count

    if count == 1
      attributes = [
      :design_car, :performance_car, :fuel_consumptionrev_car, :quietness_car,
      :vibration_car, :indoor_space_car, :luggage_space_car, :price_car,
      :maintenance_cost_car, :safety_car, :assistance_car, :evaluation_car
      ]

      attributes.each do |attr|
        @review.car_item.send("#{attr}=", 3.0)
      end

      @review.car_item.review_count = 0
      @review.car_item.save
    else
      attributes = [
        :design, :performance, :fuel_consumptionrev, :quietness, :vibration,
        :indoor_space, :luggage_space, :price, :maintenance_cost, :safety,
        :assistance, :evaluation
      ]

      attributes.each do |attr|
        current_value = @review.car_item.send("#{attr}_car")
        updated_value = (((current_value * count) - @review.send(attr)) / (count - 1)).round(1)
        @review.car_item.send("#{attr}_car=", updated_value)
      end

      @review.car_item.review_count -= 1
      @review.car_item.save
    end
    car_item_evaluation_cal_debug
  end
  
  def tag_count_delete
    tag_counts = {
      "通勤通学" => :commuting_tag_count,
      "送迎" => :pick_up_tag_count,
      "買い物" => :shopping_tag_count,
      "スポーツ" => :sports_tag_count,
      "アウトドア" => :outdoor_tag_count,
      "オフロード" => :offroad_tag_count,
      "長距離" => :long_distance_tag_count,
      "走りを楽しむ" => :enjoy_tag_count
    }

    @review.tags.each do |tag|
      attribute = tag_counts[tag.name]
      if attribute
        current_value = @review.car_item.send(attribute)
        if current_value > 0
          @review.car_item.update(attribute => current_value - 1)
        end
      end
    end
  end