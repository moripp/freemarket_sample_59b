Rails.application.routes.draw do
  get 'mypages/index'
  root "home#index"
  devise_for :users
  resources :items, only: [:new, :create]
  resources :profiles,only: [:new,:index]
  resources :credit_cards,only: [:index, :new]
end
