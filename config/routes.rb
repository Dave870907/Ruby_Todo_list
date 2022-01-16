Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tasks
  resources :labels

  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #user
  
  namespace :admin do
    resources :users , only: [:create, :show, :edit, :update, :destroy]
    get 'sign_up', to: 'users#new'
    root 'users#index'
  end
  

  root 'tasks#index'


  match '/404', to: "errors#not_found", via: :all
  match '/500', to: "errors#internal_server_error", via: :all
end
