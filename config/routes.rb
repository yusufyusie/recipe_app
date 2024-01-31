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
  resources :recipes

  # dynamic pages
  get 'public_recipes', to: 'recipes#public_recipes'
end
