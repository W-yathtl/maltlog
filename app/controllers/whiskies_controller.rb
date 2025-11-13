class WhiskiesController < ApplicationController
  before_action :move_to_index, except: [:index,:show]  
  def index
    
  end

  def new
    @whisky = Whisky.new
    @aroma_options = [
      ['sweet', '甘味 (バニラ, 蜂蜜)'],
      ['citrus', '柑橘 (レモン, オレンジ)'],
      ['cream', 'クリーム (バター, ナッツ)'],
      ['flower', '花 (フローラル)'],
      ['wine', 'ワイン (シェリー, 熟成感)'],
      ['iodine', 'ヨード (薬品, 磯)'],
      ['peat', 'ピート (スモーキー)']
    ]
  end

  def show
  end

  private

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
