class Review < ApplicationRecord
  belongs_to :car_item
  belongs_to :user
  # has_many :review_scene_relations, dependent: :destroy
  #has_many :scenes, through: :review_scene_relations, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  validates :car_item_id, presence: true
  validates :user_id, presence: true
  validates :scene_a, presence: true
  validates :scene_b, presence: true
  validates :favorite, presence: true
  validates :complain, presence: true
  validates :design, presence: true
  validates :fuel_consumptionrev, presence: true
  validates :quietness, presence: true
  validates :vibration, presence: true
  validates :indoor_space, presence: true
  validates :luggage_space, presence: true
  validates :price, presence: true
  validates :maintenance_cost, presence: true
  validates :safety, presence: true
  validates :assistance, presence: true
  validates :evaluation, presence: true
  validates :title_rev, presence: true

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
