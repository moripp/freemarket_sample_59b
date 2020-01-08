Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:new,:index]
  resources :credit_cards,only: [:index, :new]

  # ウィザード形式の記述
  resources :signup do
    collection do
      get 'input_user_info'
      get 'input_phone_number'
      get 'input_address'
      get 'input_payment' # 入力最終ステップ
      get 'completion_registration' # 登録完了後のページ
    end
  end
  
end
