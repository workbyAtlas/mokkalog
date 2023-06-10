Rails.application.routes.draw do
  resources :collections
  get 'users/profile'
  get 'closets/update'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/u/:id', to: 'users#profile', as: 'user'


  resources :brands
  resources :tags
  #root 'posts#index'
  root 'pages#index'
  
  get 'about'  => 'pages#about'
  get 'search' => 'pages#search'
  
  resources :posts do
    resources :comments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
