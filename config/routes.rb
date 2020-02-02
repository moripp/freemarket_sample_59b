Rails.application.routes.draw do
  devise_for :users  
  root "home#index"
  resources :users, only: [:index]
  resources :sitemap, only: [:index]
  resources :mypages, only: [:index]
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      post 'pay'
      get 'purchase'
      get 'show_myitem'
    end
    collection do
      get 'done'
    end
  end
  resources :profiles,only: [:new,:edit,:index]
  resources :credit_cards,only: [:index,:new,:create]
  resources :logout,only: [:index]
  # ウィザード形式の記述
  resources :signup, only: [:new] do
    collection do
      get 'select'
      get 'input_user_info'
      get 'input_phone_number'
      get 'input_address'
      get 'input_payment' # 入力最終ステップ
      get 'completion_registration' # 登録完了後のページ

  end
 end
end
