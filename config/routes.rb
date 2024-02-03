Rails.application.routes.draw do
  devise_for :users, path: 'auth',
                   path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',
                                 confirmation: 'verification', unlock: 'unblock',
                                 registration: 'register', sign_up: 'cmon_let_me_in' }

devise_scope :user do
  get 'auth/logout', to: 'devise/sessions#destroy'
end

  root 'pages#index'
  get 'home', to: 'pages#index'
  get 'up', to: 'rails/health#show', as: :rails_health_check

  authenticate :user do
    resources :users do
      resources :recipes do
        resources :recipe_foods
      end
      resources :foods do
        resources :recipe_foods
      end
    end
  end

  get 'foods', to: 'foods#index', as: :foods
  get 'public_recipes', to: 'recipes#public_recipes'
end
