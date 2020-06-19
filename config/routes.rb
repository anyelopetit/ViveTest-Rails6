Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index'

  get '/dashboard', to: 'dashboard#index', as: :dashboard

  resources :products, only: %i[show create]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
