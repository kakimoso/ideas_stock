Rails.application.routes.draw do
  root 'main_pages#home'
  get 'memos/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :memos
end
