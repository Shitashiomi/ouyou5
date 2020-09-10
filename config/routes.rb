Rails.application.routes.draw do
  root 'home#top'
  devise_for :users
  get 'home/about'
  get 'search' => 'searches#search'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
end