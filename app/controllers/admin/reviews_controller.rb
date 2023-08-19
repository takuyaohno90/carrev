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

  def update
    @review = Review.find(params[:id])
    evaluation_cal
    if @review.update(review_params)
      tag_list = params[:review][:name]
      @review.save_tag(tag_list)
      redirect_to review_path(@review.id)
    else
      puts @review.errors.full_messages
      redirect_to admin_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

    private

  def review_params
    params.require(:review).permit(:image, :title_rev, :favorite, :complain, :car_item_id, :design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance)
  end

  def evaluation_cal
    total = @review.design + @review.fuel_consumptionrev + @review.quietness + @review.vibration + @review.indoor_space + @review.luggage_space + @review.price + @review.maintenance_cost + @review.safety + @review.assistance
    @review.evaluation = (total / 10.0).round(1)
  end

end
