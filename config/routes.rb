Rails.application.routes.draw do

devise_for :users, controllers: { # カスタマイズしたdeviseのcontrollerが使えるようにする
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'select', to: 'users/registrations#index'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'credit_card', to: 'users/registrations#new_credit_card'
    post 'credit_card', to: 'users/registrations#create_credit_card'
  end
  
  root "home#index"
  resources :sitemap, only: [:index]
  resources :mypages, only: [:index]
  resources :myitems, only: [:show, :edit, :update, :destroy]
  resources :sell, only: [:new, :create]
  resources :items, only: [:show] do
    member do
      post 'pay'
      get 'purchase'
    end
    collection do
      get 'done'
    end
  end
  resources :profiles,only: [:new,:edit,:index]
  resources :credit_cards,only: [:index,:new,:create]
  resources :logout,only: [:index]
end
