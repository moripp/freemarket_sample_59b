Rails.application.routes.draw do
  root "exam#index"
  resources :items, only: [:new]
  resources :profiles,only: [:edit,:index]
end
