class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
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
    @review.destroy
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
