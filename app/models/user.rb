class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
# ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "ゲスト(姓)"
      user.first_name = "ゲスト(名)"
      user.last_name_kana = "ゲスト(セイ)"
      user.first_name_kana = "ゲスト(メイ)"
    end
  end
end
