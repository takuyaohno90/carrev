class Fuel < ApplicationRecord
  has_many :car_items, dependent: :destroy
  validates :name, presence: true
end
