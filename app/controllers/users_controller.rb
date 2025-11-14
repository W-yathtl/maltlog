# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @whiskies = @user.whiskies.order(created_at: :desc)
    @latest_whisky = @whiskies.first
  end
end