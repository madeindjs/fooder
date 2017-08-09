Rails.application.routes.draw do

  # restaurants area
  resources :restaurants # TODO: remove it

  constraints subdomain: /.+/  do
    get '/' => 'restaurants#show'

    scope '/admin' do
      get '/' => 'admin#index', as: :admin

      match 'allergens' => "admin#allergens", as: :admin_allergens, via: [:get, :post]
      # dishes
      resources :dishes, only: [:create, :new, :edit, :update, :destroy]
      match 'dishes' => "admin#dishes", as: :admin_dishes, via: [:get, :post]
      #post
      resources :posts, only: [:create, :new, :edit, :update, :destroy]
      # menus
      resources :menus, only: [:create, :new, :edit, :update, :destroy]
      match 'menus' => "admin#menus", as: :admin_menus, via: [:get, :post]
      # links
      resources :links, only: [:create, :new, :edit, :update, :destroy]
      match 'links' => "admin#links", as: :admin_links, via: [:get, :post]
      # openings hours
      match 'opening_hours' => "admin#opening_hours", as: :admin_opening_hours, via: [:get, :post]
      resources :opening_hours, only: [:create, :destroy]
      # sections
      resources :sections, only: [:create, :new, :edit, :update, :destroy]
      match 'sections' => "admin#sections", as: :admin_sections, via: [:get, :post]
      # categories
      match 'categories' => "admin#categories", as: :admin_categories, via: [:get, :post]
      resources :categories, only: [:create, :new, :edit, :update, :destroy]
      patch 'activate_module' => "restaurants#activate_module"
    end


    resources :posts, only: [:index, :show]
    resources :sections, only: [:index, :show]
    resources :menus, only: [:index, :show]
    resources :dishes, only: [:index, :show]
    resources :allergens, only: [:index]
    resources :categories, only: [:index, :show]
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
