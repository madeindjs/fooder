Rails.application.routes.draw do

  # restaurants area
  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it
  
  constraints subdomain: /.+/  do
    get '/' => 'restaurants#show'

    patch 'activate_module' => "restaurants#activate_module"

    match 'opening_hours/edit' => "opening_hours#edits", as: :opening_hours_edit, via: [:get, :post]
    resources :opening_hours, only: [:create, :destroy]

    resources :posts
    
    match 'links/edit' => "links#edits", as: :links_edit, via: [:get, :post]
    resources :links
    
    match 'sections/edit' => "sections#edits", as: :sections_edit, via: [:get, :post]
    resources :sections

    match 'menus/edit' => "menus#edits", as: :menus_edit, via: [:get, :post]
    resources :menus

    match 'dishes/allergens' => "dishes#allergens", as: :dishes_allergens_edit, via: [:get, :post]
    match 'dishes/edit' => "dishes#edits", as: :dishes_edit, via: [:get, :post]
    resources :dishes

    get 'allergens/edit' => "allergens#edits", as: :allergens_edit
    resources :allergens, only: [:index]

    match 'categories/edit' => "categories#edits", as: :categories_edit, via: [:get, :post]
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
