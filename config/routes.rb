Rails.application.routes.draw do
  root "exam#index"
  resources :items, only: [:new, :create, :show]
  resources :profiles,only: [:edit,:index]
  resources :credit_cards,only: [:index, :create]
end
