class Review < ApplicationRecord
  belongs_to :car_item
  belongs_to :user
  has_one_attached :image
end
