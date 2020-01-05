Rails.application.routes.draw do
  root "home#index"
  resources :items, only: [:new, :create, :show]
  resources :profiles,only: [:new,:edit,:index]
  resources :credit_cards,only: [:index,:new,:create]
  devise_for :users
end
