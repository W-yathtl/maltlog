class WhiskiesController < ApplicationController
  before_action :move_to_index, except: [:index,:show]  
  def index
    
  end
 def new
    @whisky = current_user.whiskies.new(aromas: []) # 初期化して配列として扱えるようにする
  end

  def create
    @whisky = current_user.whiskies.new(whisky_params)
    if @whisky.save
      redirect_to @whisky, notice: "ウイスキーを記録しました"
    else
      render :new
    end
  end

  def show
  
  end

  private

  def whisky_params
    params.require(:whisky).permit(
      :whisky_name, :drink_style, :glass_name, :glass_rating, :peat, :details,
      :whisky_photo, :glass_photo,
      aromas: [] # 配列として許可
    )
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
