Rails.application.routes.draw do
  get 'users/index'
  get 'users/index2'
  get 'users/index3'
  root "exam#index"
  
  resources :items, only: [:new]
end
