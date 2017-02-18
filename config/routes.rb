Rails.application.routes.draw do

  resources :dishes

  resources :restaurants do
    resources :dishes
  end


  resources :users
  resources :user_sessions, only: [:create, :destroy]

  get "home" => "pages#home"

  delete 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  scope '/restaurants/:id' do
    
  end

  root "pages#home"
end
