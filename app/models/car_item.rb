class CarItem < ApplicationRecord
  belongs_to :maker
  belongs_to :bodytype
  belongs_to :fuel
  has_many :reviews
  has_one_attached :car_image

  validates :maker_id, :fuel_id, :bodytype_id, :name, :num_people, :displacement, :drive_system, :door, :mission, :model_year, :fuel_consumption, :weight, :size, presence: true

  def get_image(width, height)
    unless car_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      car_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      car_image.variant(resize_to_limit: [width,height]).processed
  end

end
