class Whisky < ApplicationRecord
  belongs_to :user

  # ActiveStorage
  has_one_attached :whisky_photo
  has_one_attached :glass_photo

  # 定数として許可される香りの値を定義
  ALLOWED_AROMAS = %w[sweet citrus cream flower wine iodine peat].freeze

  # バリデーション
  validates :whisky_name, :drink_style, presence: true
  validates :glass_rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :details, length: { maximum: 1000 }, allow_nil: true

  # JSONバリデーション（aromasがJSON配列かつ許可された値のみか）
  validates :aromas, json: { schema: { type: "array", items: { enum: ALLOWED_AROMAS } } }, allow_nil: true
end
