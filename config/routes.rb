Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'home' => 'static#home'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end


  resources :categories, only: [:show]

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
