Rails.application.routes.draw do
  get 'users/index'
  get 'users/index2'
  root "exam#index"
  
  resources :items, only: [:new]
end
