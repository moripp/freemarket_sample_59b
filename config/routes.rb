Rails.application.routes.draw do
  
  root "exam#index"
  
  resources :items, only: [:new]
  resources :users do
            
    collection do
      get 'index'
      get 'index2'
      get 'index3'
      get 'index4'
      get 'index5'
      get 'index6' 
      get 'index7' 
    end
  end
end
