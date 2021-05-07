Rails.application.routes.draw do

  resources :reviews
  resources :movies
  resources :users
  resources :friendships

end
