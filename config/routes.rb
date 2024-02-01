Rails.application.routes.draw do
  # Devise routes
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' },
                     controllers: { sessions: 'users/sessions' },
                     skip: :all

  devise_scope :user do
  get 'login', to: 'devise/sessions#new', as: :new_user_session
  post 'login', to: 'devise/sessions#create', as: :user_session
  delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  get 'register', to: 'devise/registrations#new', as: :new_user_registration
  post 'register', to: 'devise/registrations#create', as: :user_registration
  get 'secret', to: 'devise/passwords#new', as: :new_user_password
  get 'confirmation', to: 'devise/confirmations#new', as: :new_user_confirmation
end

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
