class Scene < ApplicationRecord
  has_many :review_scene_relations, dependent: :destroy
  has_many :reviews, through: :review_scene_relations, dependent: :destroy
  validates :name, presence: true
end
