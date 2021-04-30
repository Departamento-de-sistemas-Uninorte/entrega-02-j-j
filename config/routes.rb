Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :tweets
  #get '/index', to: 'tweets#index'
  namespace :api do
    namespace :v1 do
      #resources :tweets #, only: [:index]
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
      devise_scope :tweets do
        get '/tweets', to: 'tweet#index'
        post '/tweet', to: 'tweet#create'
        get '/tweet/:id', to: 'tweet#show'
        delete '/tweet/:id', to: 'tweet#destroy'
      end
    end
  end
  
end
