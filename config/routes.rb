Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :tasks
  #get '/index', to: 'tasks#index'
  namespace :api do
    namespace :v1 do
      #resources :tasks #, only: [:index]
      resources :follow #, only: [:index]
      resources :timeline
      resources :followers


      devise_scope :follow do
        post '/follow/:id', to: 'follow#create'
      end

      devise_scope :user do
        post '/signup', to: 'registrations#create'
        post '/auth/login', to: 'sessions#create'
        delete '/auth/logout', to: 'sessions#destroy'
      end
      devise_scope :tasks do
        get '/tweet', to: 'task#index'
        post '/tweet', to: 'task#create'
        get '/tweet/:id', to: 'task#show'
        delete '/tweet/:id', to: 'task#destroy'
      end
    end
  end
  
end
