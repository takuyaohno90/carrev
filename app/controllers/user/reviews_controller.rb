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
    if @review.save
      tag_list = tag_params[:name].delete(" ").split(",")
      @review.save_tag(tag_list)
      redirect_to user_review_url(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @review = Review.find(params[:id])
    @review_tags = @review.tags
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end

  private

  def review_params
    params.require(:review).permit(:title_rev, :scene_a, :scene_b, :favorite, :complain, :car_item_id)
  end

  def tag_params
    params.require(:review).permit(:name)
  end
end
