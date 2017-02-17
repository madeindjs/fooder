Rails.application.routes.draw do

  resources :categories
  resources :dishes
  resources :restaurants
  resources :users
  resources :user_sessions, only: [:create, :destroy]

  get "home" => "pages#home"


  delete 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  root "pages#home"
end
