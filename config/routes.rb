Rails.application.routes.draw do

  
  get 'posts/create'
  get 'posts/destroy'
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
 resources :users
 resources :posts, only: [:create, :destroy]
end
