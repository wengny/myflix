Myflix::Application.routes.draw do

  root :to => 'static#front'
  get 'home' => 'static#home'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show, :index] do
    collection do
      get 'search', to: 'videos#search'
    end
  end

  resources :categories, only: [:show]

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  #resources :sessions, only: [:create]


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
