Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create, :show]
  resources :profiles,only: [:new,:edit,:index]
  resources :credit_cards,only: [:index,:new,:create]
end
