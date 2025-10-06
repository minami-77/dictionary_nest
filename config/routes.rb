Rails.application.routes.draw do

  # Home page
  root to: 'pages#home'

  # API Group
    namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Devise API
      devise_for :users,

        # Customize paths
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },

        # Customize controllers
        controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations'
        }

      # Other APIs
      resources :pages, only: [:index]
      resources :words, only: [:index]
      get "users/me", to: "users#me"
    end
  end
end
