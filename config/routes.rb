Rails.application.routes.draw do

    root 'sessions#home'

    get '/signup' => 'users#new'
    post '/signup' => 'users#create'

    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    delete '/logout' => 'sessions#destroy'

    get '/auth/:provider/callback' => 'sessions#google'

    get 'search/index'

    resources :search
    resources :reviews
    resources :movies, only: [:index, :show] do
        resources :reviews#, shallow: true
    end
    resources :users do
        resources :reviews, shallow: true
    end
    resources :friendships

    get "*path", to: redirect('/')
end
