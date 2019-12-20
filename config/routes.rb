Rails.application.routes.draw do
  get 'mypages/index'
  root "exam#index"
  resources :items, only: [:new]
end
