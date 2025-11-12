Rails.application.routes.draw do
  devise_for :users
  root "whiskies#index"
  resources :whiskies, only: :index
end
