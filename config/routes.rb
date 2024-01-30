Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Static pages
  get 'home', to: 'pages#index'
  root "pages#index"

  # dynamic pages
  get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  post 'recipes', to: 'recipes#create'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resource routes
  resources :foods, only: [:index, :show]
  resources :recipes, only: [:index, :show, :create, :update, :destroy]
end
