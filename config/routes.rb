# config/routes.rb
Rails.application.routes.draw do
  # Devise の認証機能
  devise_for :users
  
  # ウイスキー記録機能（RESTful routes）
  resources :whiskies do
    collection do
     get :search
     get :result
    end
  end
  
  # ユーザープロフィール
  resources :users, only: [:show]
  
  # ルートパス
  authenticated :user do
    root to: "whiskies#index", as: :authenticated_root
  end
  
  # 未ログインの場合はログインページへ
  root to: redirect('/users/sign_in')
end