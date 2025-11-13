# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    # 現在のログインユーザーを@userに設定
    @user = current_user
    @whiskies = @user.whiskies.order(created_at: :desc).to_a
  end
end