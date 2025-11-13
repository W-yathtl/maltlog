# app/controllers/whiskies_controller.rb
class WhiskiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_whisky, only: [:show, :edit, :update, :destroy]
  
  # GET /whiskies
  def index
    @whiskies = current_user.whiskies.order(created_at: :desc)
  end
  
  # GET /whiskies/:id
  def show
    
  end
  
  # GET /whiskies/new
  def new
    @whisky = Whisky.new
    @whisky.aromas ||= [] # 空の配列で初期化
  end
  
  # POST /whiskies
  def create
    @whisky = current_user.whiskies.build(whisky_params)
    
    if @whisky.save
      redirect_to whiskies_path, notice: 'ウイスキーを記録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
   def edit
    # @whiskyは既にset_whiskyで設定済み
  end

  def update
    if @whisky.update(whisky_params)
      redirect_to @whisky, notice: 'ウイスキーログを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @whisky.destroy
    redirect_to user_path(current_user), notice: 'ウイスキーログを削除しました。'
  end

def search
  @whiskies = Whisky.all

  # ピートの条件
  if params[:peat].present?
    @whiskies = @whiskies.where(peat: params[:peat])
  end

  # 香りの条件（複数選択対応）
  if params[:aromas].present?
    params[:aromas].each do |aroma|
      @whiskies = @whiskies.where("aromas LIKE ?", "%#{aroma}%")
    end
  end

  # キーワード検索
  if params[:query].present?
    @whiskies = @whiskies.where("whisky_name LIKE ?", "%#{params[:query]}%")
  end
end
  
  private
  
  def set_whisky
    @whisky = Whisky.find(params[:id])
  end
  
 def whisky_params
  params.require(:whisky).permit(
    :whisky_name, 
    :drink_style, 
    :glass_name, 
    :glass_rating, 
    :peat, 
    :details, 
    :whisky_photo,  # 追加
    :glass_photo,   # 追加
    aromas: []
  )
  end
end