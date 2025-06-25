Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  root to: 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :pages, only: [:index]
    end
  end
end
