class Whisky < ApplicationRecord
  belongs_to :user
  has_one_attached :whisky_photo
  has_one_attached :glass_photo

  validates :whisky_name, :drink_style, presence: true
  validates :glass_rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :aromas, json: true # 任意でJSONバリデーション（gem必要）
end
end
