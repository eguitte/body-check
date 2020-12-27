Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'toppages#index'
 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
