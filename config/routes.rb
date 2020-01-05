Rails.application.routes.draw do
  root "exam#index"
  resources :mypages, only: [:index]
  resources :items, only: [:new]
end
