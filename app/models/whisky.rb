class Whisky < ApplicationRecord
  belongs_to :user

  has_one_attached :whisky_photo
  has_one_attached :glass_photo

  ALLOWED_AROMAS = %w[sweet citrus cream flower wine iodine peat].freeze

  validates :whisky_name, :drink_style, presence: true
  validates :glass_rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :details, length: { maximum: 300 }, allow_nil: true

  validate :aromas_must_be_array_of_allowed_values

  private

  def aromas_must_be_array_of_allowed_values
    return if aromas.blank? # 任意なので空は許可

    unless aromas.is_a?(Array) && aromas.all? { |a| ALLOWED_AROMAS.include?(a) }
      errors.add(:aromas, "は正しい香りの配列である必要があります")
    end
  end
end