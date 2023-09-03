class User::ReviewsController < ApplicationController
  def search
    @maker = Maker.all
  end

  def result_new_maker
    @maker = Maker.find(params[:id])
  end

  def result
    keyword = params[:keyword]
    @search_results = CarItem.where("name LIKE ?", "%#{keyword}%")
  end

  def new
    id = params[:car_item_id]
    @car_item = CarItem.find(id)
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    #車種評価点数計算
    evaluation_cal
    #tag_list = params[:review][:name].split(",")

    if @review.save
      #各評価点数をcar_itemに保存
      car_item_evaluation_cal
      redirect_to new_tag_user_reviews_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def new_tag
    @review = Review.find(params[:id])
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
  end

  def create_tag
    @review = Review.find(params[:id])
    if @review.tags.present?
      tag_count_delete
    end
    @tag_list = params[:review][:name]
    @review.save_tag(@tag_list)
    tag_count
    redirect_to user_review_path(@review.id)
  end

  def show
    @review = Review.find(params[:id])
    @review_tags = @review.tags
    @comment = Comment.new
    #非公開記事詳細ページは、他のユーザーがアクセス時にはリダイレクトさせる
    if @review.user != current_user && @review.status == 1
      redirect_to root_path
    end
  end

  def edit
    @review = Review.find(params[:id])
    #編集画面ページは、他のユーザーがアクセス時にはリダイレクトさせる
    unless @review.user == current_user
      redirect_to root_path
    end
  end

  def update
    @review = Review.find(params[:id])
    car_item_evaluation_cal_delete
    evaluation_cal_update
    if @review.update(review_params)
      car_item_evaluation_cal
      redirect_to new_tag_user_reviews_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @car_items = CarItem.all
    #reset_car_item
    #car_item_evaluation_cal_delete
    if @review.tags.present?
      tag_count_delete
    end
    @review.destroy
    redirect_to user_reviews_path
  end

  def index
    @reviews = Review.where(status: 0)
    @tag_list = Tag.all
  end

  def tag_search
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:id])
    #検索されたタグに紐づく投稿を表示
    @reviews = @tag.reviews.where(status: 0)
  end

  def search_rev
    @maker = Maker.all
    @tag_list = Tag.all
  end

  def result_rev_maker
    @maker = Maker.find(params[:id])
  end

  def result_rev_carname
    keyword = params[:keyword]
    @car_item = CarItem.where("name LIKE ?", "%#{keyword}%")
  end

  def index_rev_carname
    id = params[:car_item_id]
    car_item = CarItem.find(id)
    @reviews = car_item.reviews
  end

  private
#, tag_ids: []
  def review_params
    params.require(:review).permit(:image, :title_rev, :favorite, :complain, :car_item_id, :design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance, :status, :maker_id)
  end

  def evaluation_cal
    total = @review.design + @review.performance + @review.fuel_consumptionrev + @review.quietness + @review.vibration + @review.indoor_space + @review.luggage_space + @review.price + @review.maintenance_cost + @review.safety + @review.assistance
    @review.evaluation = (total / 11.0).round(1)
  end

  def evaluation_cal_update
    total = params[:review][:design].to_i + params[:review][:performance].to_i + params[:review][:fuel_consumptionrev].to_i + params[:review][:quietness].to_i + params[:review][:vibration].to_i + params[:review][:indoor_space].to_i + params[:review][:luggage_space].to_i+ params[:review][:price].to_i + params[:review][:maintenance_cost].to_i + params[:review][:safety].to_i + params[:review][:assistance].to_i
    @review.evaluation = (total / 11.0).round(1)
  end

  def car_item_evaluation_cal
    count = @review.car_item.review_count
    attributes_to_update = [:design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance, :evaluation]

    attributes_to_update.each do |attr|
    current_value = @review.car_item.send("#{attr}_car")
    new_value = (((current_value * count) + @review.send(attr)) / (count + 1)).round(1)
    @review.car_item.send("#{attr}_car=", new_value)
    end

    @review.car_item.review_count += 1
    car_item_evaluation_cal_debug
    @review.car_item.save
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

  def tag_count
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

    @tag_list.each do |tag|
      if attribute = tag_counts[tag]
       @review.car_item.increment(attribute)
      end
    end

    @review.car_item.save
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


  def reset_car_item
   attributes_to_reset = {
      commuting_tag_count: 0,
      pick_up_tag_count: 0,
      shopping_tag_count: 0,
      sports_tag_count: 0,
      outdoor_tag_count: 0,
      offroad_tag_count: 0,
      long_distance_tag_count: 0,
      enjoy_tag_count: 0,
      design_car: 3.0,
      performance_car: 3.0,
      fuel_consumptionrev_car: 3.0,
      quietness_car: 3.0,
      vibration_car: 3.0,
      indoor_space_car: 3.0,
      luggage_space_car: 3.0,
      price_car: 3.0,
      maintenance_cost_car: 3.0,
      safety_car: 3.0,
      assistance_car: 3.0,
      evaluation_car: 3.0,
      review_count: 0
    }

    @car_items.each do |car_item|
      attributes_to_reset.each do |attr, value|
        car_item.update(attr => value) if car_item.has_attribute?(attr)
      end
    end
  end

end