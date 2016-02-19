Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  root 'pages#home'
  
    resources :users do
      member do
        get 'followers'
        get 'following'
      end
    end
    
  
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    
    get 'about', to: 'pages#about'
    get 'contact', to: 'pagescontact'
    get 'help', to: 'pages#help'
    get 'signup', to: 'users#new'
    get 'signin', to: 'sessions#new'
    match 'signout', to: 'sessions#destroy', via: :delete
end
