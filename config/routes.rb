Rails.application.routes.draw do
  get 'mypages/index'
  resources :index
  resources :items, only: [:new]
end
