Rails.application.routes.draw do

  resources :mailings
  # restaurants area
  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it
  get 'send_commercial_mail/:id' => "restaurants#send_commercial_mail", as: :send_commercial_mail

  constraints subdomain: /.+/  do
    get '/' => 'restaurants#show'

    scope '/admin' do
      get '/' => 'admin#index', as: :admin
      match 'allergens' => "admin#allergens", as: :admin_allergens, via: [:get, :post]
      match 'dishes/import' => "dishes#import", via: [:get, :post]
      match 'dishes' => "admin#dishes", as: :admin_dishes, via: [:get, :post]
      match 'menus' => "admin#menus", as: :admin_menus, via: [:get, :post]
      match 'opening_hours' => "admin#opening_hours", as: :admin_opening_hours, via: [:get, :post]
      match 'links' => "admin#links", as: :admin_links, via: [:get, :post]
      match 'sections' => "admin#sections", as: :admin_sections, via: [:get, :post]
      match 'categories' => "admin#categories", as: :admin_categories, via: [:get, :post]
    end

    patch 'activate_module' => "restaurants#activate_module"

    resources :opening_hours, only: [:create, :destroy]
    resources :posts
    resources :links
    resources :sections
    get '/menus/:id/copy' => "menus#copy", as: :copy_menu
    resources :menus
    resources :dishes
    resources :allergens, only: [:index]
    resources :categories
  end

  # payements area
  post "/hook" => "payements#hook", as: :payement_hook
  resources :payements

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
