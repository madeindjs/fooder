Rails.application.routes.draw do

  get "signup" => "users#new"
  get "signin" => "user_sessions#new"
  post "signin" => "user_sessions#create"

  get "home" => "pages#home"

  resources :users
  resources :user_sessions
  root "pages#home"
end
