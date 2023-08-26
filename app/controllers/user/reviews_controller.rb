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
    #tag_list = params[:review][:name].split(",")

    if @review.save
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
    tag_list = params[:review][:name]
    @review.save_tag(tag_list)
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
    evaluation_cal_update
    if @review.update(review_params)
      evaluation_cal
      @review.save
      redirect_to new_tag_user_reviews_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
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

  private
#, tag_ids: []
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
