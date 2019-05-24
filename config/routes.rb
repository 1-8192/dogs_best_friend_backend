Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :dogs, only: [:index, :show]
      resources :users, only: [:create, :update, :destroy]
      resources :shelters, only: [:index]
      resources :payments, only: [:create]
      resources :charges, only: [:new, :create]

      get '/need', to: 'dogs#sorted_index'
      post '/register', to: 'users#create'
      post '/login', to: 'auth#create'
      get '/current_user', to: 'auth#current_profile'
      get '/profile', to: 'users#profile'
    end
  end
end
