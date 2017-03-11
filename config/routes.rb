Rails.application.routes.draw do

  
  get 'cost' => 'pages#cost'

  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it


  constraints subdomain: /.+/  do
    get 'contact' => "restaurants#contact"
    get 'allergens' => "restaurants#allergens"
    patch 'activate_module' => "restaurants#activate_module"

    resources :opening_hours, only: [:create, :update, :destroy]
    resources :menus
    resources :posts
    resources :sections

    resources :dishes
  end


  resources :users
  resources :user_sessions, only: [:create, :destroy]


  get 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  get "home" => "pages#home"
  get '/' => 'restaurants#show', constraints: { subdomain: /.+/ }
  get '/', to:  'restaurants#show', constraints: { subdomain: 'le-petit-lagon-bleu'}, as: :example

  root 'pages#home'
end
