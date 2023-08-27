class Maker < ApplicationRecord
  has_many :car_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
end
