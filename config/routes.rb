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
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create, :show]
  #resources :sessions, only: [:create]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  
  get 'my_queue', to: 'queue_items#index'
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to:'queue_items#update_queue'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirmation'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'static#expired_token'

  resources :invitations, only: [:new, :create]

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
