Rails.application.routes.draw do

  
  get 'cost' => 'pages#cost'

  resources :categories, only: [:create, :new, :edit, :update, :destroy]

  resources :restaurants do
    get 'contact'
    patch 'activate_module'

    resources :opening_hours, only: [:create, :update, :destroy]
    resources :menus
    resources :posts
    resources :dishes
    resources :sections
  end



  resources :users
  resources :user_sessions, only: [:create, :destroy]


  get 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  get "home" => "pages#home"
  get '/' => 'restaurants#show', constraints: { subdomain: /.+/ }

  root 'pages#home'
end
