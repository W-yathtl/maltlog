class Whisky < ApplicationRecord
  belongs_to :user
  
  # Active Storage で画像を添付
  has_one_attached :whisky_photo
  has_one_attached :glass_photo
  
  # バリデーション
  validates :whisky_name, presence: true
  validates :drink_style, presence: true
  validates :glass_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  
  # 飲み方の選択肢
  DRINK_STYLES = %w[straight on_the_rock highball mizuwari oyuwari other].freeze
  validates :drink_style, inclusion: { in: DRINK_STYLES }
  
  # 香りの選択肢
  AROMA_OPTIONS = %w[sweet citrus cream flower wine iodine peat].freeze
  validate :validate_aromas
  validate :at_least_one_aroma
  
  private
  
  def validate_aromas
    return if aromas.blank?
    
    invalid_aromas = aromas - AROMA_OPTIONS
    if invalid_aromas.any?
      errors.add(:aromas, "に無効な値が含まれています: #{invalid_aromas.join(', ')}")
    end
  end
  
  def at_least_one_aroma
    if aromas.blank? || aromas.empty? || aromas.all?(&:blank?)
      errors.add(:aromas, "を最低1つ選択してください")
    end
  end
end