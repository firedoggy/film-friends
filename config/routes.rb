Rails.application.routes.draw do

    root 'sessions#home'

    get '/signup' => 'users#new'
    post '/signup' => 'users#create'

    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    post '/logout' => 'sessions#destroy'

    get 'search/index'
    resources :search

    resources :reviews
    resources :movies
    resources :users
    resources :friendships

end
