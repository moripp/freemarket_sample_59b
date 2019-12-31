Rails.application.routes.draw do
  devise_for :users
  root "exam#index"
  resources :items, only: [:new]
end
