Myflix::Application.routes.draw do

  root :to => 'static#front'
  get 'home' => 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  #resources :sessions, only: [:create]
  
  get 'my_queue', to: 'queue_items#index'

  resources :queue_items, only: [:create, :destroy]

  post 'update_queue', to:'queue_items#update_queue'

  # root to: 'todo#index'
  # resources :todos, only: [:index] do
  #   collection do 
  #     get 'search', to: 'todos#search'
  #   end

  #   member do
  #     post 'hightlight', to: 'todos#highlight'
  #   end
  # end
  
end
