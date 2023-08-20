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
      tag_list = params[:review][:name] #["通勤通学", "送迎"]
      #@review.save_tag(tag_list)
      #新規タグを登録していく
      tag_list.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        unless tag
          new_tag = Tag.create(name: tag_name)
          if new_tag.persisted?
            puts "タグ登録成功"
          else
            puts "タグ登録失敗"
          end
        end
      end
      #登録済みのtaggingがある場合削除
      if Tagging.find_by(review_id: @review.id)
        Tagging.where(review_id: @review.id).destroy_all
      end
      #taggingを登録していく
      tag_list.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        if tag
          tagging = Tagging.new(review_id: @review.id, tag_id: tag.id)
          if tagging.save
            puts "tagging登録成功"
          else
            puts "tagging登録失敗"
          end
        else
          puts "タグがTagモデルに存在しません"
        end
      end
      redirect_to user_review_url(@review.id)
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
    params.require(:review).permit(:image, :title_rev, :favorite, :complain, :car_item_id, :design, :performance, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance)
  end

  def evaluation_cal
    total = @review.design + @review.fuel_consumptionrev + @review.quietness + @review.vibration + @review.indoor_space + @review.luggage_space + @review.price + @review.maintenance_cost + @review.safety + @review.assistance
    @review.evaluation = (total / 10.0).round(1)
  end

end
