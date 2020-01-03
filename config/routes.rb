Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:edit,:index]
  resources :credit_cards,only: [:index, :new]
end
