Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  } 
  devise_scope :user do
    get "sign_up", :to => "users/registrations#new"
    get "sign_in", :to => "users/sessions#new"
  end
  root "home#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:new,:index]
  resources :credit_cards,only: [:index, :new]
end
