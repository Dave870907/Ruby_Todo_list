Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]

  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #user
  get 'admin' ,to: 'users#index'
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]
  
  root 'tasks#index'
end
