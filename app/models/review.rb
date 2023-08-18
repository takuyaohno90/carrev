class Review < ApplicationRecord
  belongs_to :car_item
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy
  has_one_attached :image

  validates :car_item_id, :user_id, :favorite, :complain, :design, :fuel_consumptionrev, :quietness, :vibration, :indoor_space, :luggage_space, :price, :maintenance_cost, :safety, :assistance, :evaluation, :title_rev, presence: true

  def save_tag(sent_tags) #sent_tags=["aaa", "bbb", "ccc"]]→新規投稿のparams[:rweview][:name]で送られてくる
    current_tags = self.tags.pluck(:name) unless self.tags.nil? #新規投稿の場合は空
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(name: new)
      self.tags << new_tag
    end
  end

end
