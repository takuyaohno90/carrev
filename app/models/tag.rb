class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :reviews, through: :taggings, dependent: :destroy

  validates :name, presence: true, uniqueness: true

    private

    # タグ名を小文字に変換
    def downcase_tag_name
      self.name.downcase!
    end
end
