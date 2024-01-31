Rails.application.routes.draw do
  # Devise routes
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
 end

  # Static pages
  get 'index', to: 'pages#index', as: :index
  root "pages#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resource routes
  resources :foods, only: [:index, :show]
  resources :recipes

  # dynamic pages
  get 'public_recipes', to: 'recipes#public_recipes'
end
