Rails.application.routes.draw do
  # Devise routes
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Static pages
  get 'home', to: 'pages#index'
  root "pages#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Resource routes
  resources :users do
      resources :recipes, only: [:index, :new, :create, :destroy] do
        resources :foods, only: [:index, :new, :create, :destroy] do
          resources :recipe_foods, only: [:show, :edit, :update, :destroy]
      end
    end
  end
  

  # dynamic pages
  get 'public_recipes', to: 'recipes#public_recipes'
end
