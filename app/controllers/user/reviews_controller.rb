class User::ReviewsController < ApplicationController
  def search
  end

  def result
    keyword = params[:keyword]
    @search_results = CarItem.where("name LIKE ?", "%#{keyword}%")
  end

  def new
    id = params[:car_item_id]
    @car_item = CarItem.find(id)
    @review = Review.new
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    evaluation_cal
    if @review.save
      tag_list = params[:review][:name]
      #@review.save_tag(tag_list)
      
      byebug
      redirect_to user_review_url(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @review = Review.find(params[:id])
    @review_tags = @review.tags
    @comment = Comment.new
    #非公開記事詳細ページは、他のユーザーにアクセス時にはリダイレクトさせる
    unless @review.user == current_user
      redirect_to root_path
    end
  end

  def edit
    @review = Review.find(params[:id])
    @review_tags = @review.tags
    @default_tags = ["通勤通学", "送迎", "買い物", "スポーツ", "アウトドア", "オフロード", "長距離", "走りを楽しむ"]
  end

  def update
    @review = Review.find(params[:id])
    evaluation_cal
    if @review.update(review_params)
      tag_list = params[:review][:name]
      @review.save_tag(tag_list)
      redirect_to user_review_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  def index
    @reviews = Review.where(status: 0)
  end

  private

  def review_params
    params.require(:review).permit(:image, :title_rev, :favorite, :complain, :car_item_id, :design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance, :status)
  end

  def evaluation_cal
    total = @review.design + @review.fuel_consumptionrev + @review.quietness + @review.vibration + @review.indoor_space + @review.luggage_space + @review.price + @review.maintenance_cost + @review.safety + @review.assistance
    @review.evaluation = (total / 10.0).round(1)
  end
end
