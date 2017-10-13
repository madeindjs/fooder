Rails.application.routes.draw do

  resources :mailings
  # restaurants area
  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it

  constraints subdomain: /.+/  do
    get '/' => 'restaurants#show'

    patch 'activate_module' => "restaurants#activate_module"

    resources :posts
    resources :links
    resources :sections
    get '/menus/:id/copy' => "menus#copy", as: :copy_menu
    resources :menus, :only => [ :new, :create, :edit, :update, :destroy]
    resources :dishes, :only => [ :new, :create, :edit, :update, :destroy]
    # resources :allergens, only: [:index]
  end

  # payements area
  post "/hook" => "payements#hook", as: :payement_hook
  resources :payements

  resources :opening_hours, only: [:new, :create, :update, :edit, :destroy]
  # session
  resources :users
  resources :user_sessions, only: [:create, :destroy]
  get 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"
  get "confirm_email/:token" => "users#confirm_email", as: 'confirm_email'
  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  # pages area
  match 'contact' => 'pages#contact', via: [:get, :post]
  get 'cost' => 'pages#cost'
  get "home" => "pages#home"
  get '/', to:  'restaurants#show', constraints: { subdomain: 'le-petit-lagon-bleu'}, as: :example

  resources :newsletters, only: [:create, :destroy]

  root 'pages#home'
end
