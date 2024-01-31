Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Static pages
  get 'home', to: 'pages#index'
  root "pages#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resource routes
  resources :foods, only: [:index, :show]
  resources :recipes, only: [:index, :show, :create, :update, :destroy]

    # dynamic pages
    get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
    post 'recipes', to: 'recipes#create'
    get '/public_reciipes', to: 'reciipes#public_reciipes', as: 'public_reciipes'
end
