class CarItem < ApplicationRecord
  belongs_to :maker
  belongs_to :bodytype
  belongs_to :fuel
  has_many :reviews

  validates :maker_id, presence: true
  validates :fuel_id, presence: true
  validates :bodytype_id, presence: true
  validates :name, presence: true
  validates :num_people, presence: true
  validates :displacement, presence: true
  validates :drive_system, presence: true
  validates :door, presence: true
  validates :mission, presence: true
  validates :model_year, presence: true
  validates :fuel_consumption, presence: true
  validates :weight, presence: true
  validates :size, presence: true
end
