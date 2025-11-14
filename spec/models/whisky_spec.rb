require 'rails_helper'

require 'rails_helper'

RSpec.describe Whisky, type: :model do
  before do
    @whisky = FactoryBot.build(:whisky)
  end

  describe 'ウイスキー記録の保存' do
    context '保存できる時' do
      it '全ての値が正しく入力されている場合保存できる' do
        expect(@whisky).to be_valid
      end

      it 'glass_rating が 1〜5 の範囲なら保存できる' do
        @whisky.glass_rating = 3
        expect(@whisky).to be_valid
      end

      it 'aromas が空でも保存できる' do
        @whisky.aromas = nil
        expect(@whisky).to be_valid
      end
    end

    context '保存できない時' do
      it 'user が紐付いていないと保存できない' do
        @whisky.user = nil
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("User must exist")
      end

      it 'whisky_name が空では保存できない' do
        @whisky.whisky_name = ''
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Whisky name can't be blank")
      end

      it 'drink_style が空では保存できない' do
        @whisky.drink_style = ''
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Drink style can't be blank")
      end

      it 'drink_style が規定外の値では保存できない' do
        @whisky.drink_style = 'invalid_style'
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Drink style is not included in the list")
      end

      it 'glass_rating が 1 未満では保存できない' do
        @whisky.glass_rating = 0
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Glass rating must be greater than or equal to 1")
      end

      it 'glass_rating が 6 以上では保存できない' do
        @whisky.glass_rating = 6
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Glass rating must be less than or equal to 5")
      end

      it 'glass_rating が整数以外では保存できない' do
        @whisky.glass_rating = 3.5
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Glass rating must be an integer")
      end

      it 'aromas に無効な値が含まれていると保存できない' do
        @whisky.aromas = ['sweet', 'invalid_aroma']
        @whisky.valid?
        expect(@whisky.errors.full_messages).to include("Aromas に無効な値が含まれています: invalid_aroma")
      end
    end
  end
end