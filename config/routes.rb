Rails.application.routes.draw do
  # namespace :api do
  #   get 'v1/words'
  # end

  # Home page
  root to: 'pages#home'

  # API Group
  # Put every　paths under api/v1
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      # Devise(API)
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
          sessions: 'api/v1/sessions',
          registrations: 'api/v1/registrations'
        }

      # Other APIs
      resources :pages, only: [:index]
      resources :words, only: [:index, :create]
      resources :user_words, only: [:index, :show, :update, :destroy]

      # Endpoint to get current user's ID
      get "users/me", to: "users#me"

    end
  end

end
