Rails.application.routes.draw do
  root "exam#index"
  resources :items, only: [:new]
end
