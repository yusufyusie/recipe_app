Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, skip: :all, path: 'auth', controllers: { sessions: 'users/sessions' },
                     path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',
                                   confirmation: 'verification', unlock: 'unblock',
                                   registration: 'register', sign_up: 'cmon_let_me_in' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session
    get 'register', to: 'devise/registrations#new', as: :new_user_registration
    post 'register', to: 'devise/registrations#create', as: :user_registration
    get 'secret', to: 'devise/passwords#new', as: :new_user_password
    post 'secret', to: 'devise/passwords#create', as: :user_password
    get 'secret/edit', to: 'devise/passwords#edit', as: :edit_user_password
    patch 'secret', to: 'devise/passwords#update'
    get 'confirmation', to: 'devise/confirmations#new', as: :new_user_confirmation
    post 'confirmation', to: 'devise/confirmations#create', as: :user_confirmation
  end

  # Static pages
  root to: 'pages#index'
  get 'home', to: 'pages#index', as: :home

  # Health check
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Resource routes
  authenticated :user do
    resources :users do
      resources :recipes, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
        resources :recipe_foods, only: [:show, :edit, :update, :destroy]
      end
      resources :foods do
        resources :recipe_foods, only: [:show, :edit, :update, :destroy]
      end
    end
  end

  # Dynamic pages
  get 'public_recipes', to: 'recipes#public_recipes', as: :public_recipes
end
