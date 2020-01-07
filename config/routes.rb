Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :items, only: [:new, :create]
  resources :profiles,only: [:new,:index]
  resources :credit_cards,only: [:index, :new]

  # ウィザード形式の記述
  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4' # 入力最終ステップ
      get 'done' # 登録完了後のページ
    end
  end
  
end
