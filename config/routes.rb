Rails.application.routes.draw do
  get 'users/index'
  get 'users/index2'
  get 'users/index3'
  get 'users/index4'
  get 'users/index5'
  get 'users/index6'
  get 'users/index7'
  root "exam#index"
  
  resources :items, only: [:new]
end
