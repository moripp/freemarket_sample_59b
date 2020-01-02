Rails.application.routes.draw do
  root "exam#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:new,:index]
  resources :credit_cards,only: [:index, :create]
end
