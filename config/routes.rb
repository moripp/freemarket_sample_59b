Rails.application.routes.draw do
  root "exam#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:edit,:index]
  resources :credit_cards,only: [:index, :new]
end
