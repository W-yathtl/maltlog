class WhiskiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_whisky, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @whiskies = Whisky.all.order(created_at: :desc)
  end

  def show
    # @whiskyは既にset_whiskyで設定済み
    # ここには何も書かない、またはコメントのみ
  end

  def new
    @whisky = Whisky.new
  end

  def create
    @whisky = current_user.whiskies.build(whisky_params)
    if @whisky.save
      redirect_to @whisky, notice: 'ウイスキーログを作成しました。'
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
  # 初期スコープ
  @whiskies = Whisky.all.order(created_at: :desc)

  # キーワード検索（銘柄名 or 詳細メモ）
  if params[:query].present?
    query = params[:query].strip
    @whiskies = @whiskies.where("whisky_name LIKE ? OR details LIKE ?", "%#{query}%", "%#{query}%")
  end

  # ピート検索（string型として検索）
 # ピートフィルタリング
# ピートフィルタリング
case params[:peat]
when "true"
  @whiskies = @whiskies.where(peat: "true")
when "false"
  @whiskies = @whiskies.where(peat: "false")
# when "", nil の場合は何もしない（全て表示）
end
  
  # 香り検索（複数選択可）
  if params[:aromas].present? && params[:aromas].is_a?(Array)
    conditions = params[:aromas].map { |_| "JSON_CONTAINS(aromas, ?)" }.join(" OR ")
    values = params[:aromas].map { |aroma| "\"#{aroma}\"" }
    @whiskies = @whiskies.where(conditions, *values)
  end
end

  private

  def set_whisky
    @whisky = Whisky.find(params[:id])
  end

  def authorize_user!
    unless @whisky.user == current_user
      redirect_to root_path, alert: '権限がありません。'
    end
  end

  def whisky_params
    params.require(:whisky).permit(
      :whisky_name, 
      :drink_style, 
      :glass_name, 
      :glass_rating, 
      :peat, 
      :details, 
      :whisky_photo,
      :glass_photo,
      aromas: []
    )
  end
end