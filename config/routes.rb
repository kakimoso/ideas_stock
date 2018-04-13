Rails.application.routes.draw do
  get 'memos/new'
  root 'main_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'users/new'
  get 'users/create'
  get 'users/update'
  get 'users/show'
  resources :users
  resources :memos
end
