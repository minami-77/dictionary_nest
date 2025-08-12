Rails.application.routes.draw do
  devise_for :users,

  # To customize controllers
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Home page
  root to: 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :pages, only: [:index]
    end
  end
end
