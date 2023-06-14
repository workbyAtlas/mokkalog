Rails.application.routes.draw do
  resources :collections
  get 'users/profile'
  get 'closets/update'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/u/:id', to: 'users#profile', as: 'user'

  #resources :posts
  resources :brands
  resources :tags
  #root 'posts#index'
  root 'pages#index'
  
  get 'about'  => 'pages#about'
  get 'search' => 'pages#search'

  #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
  get 'posts/:id/visit', to: 'posts#visit', as: 'post_visit'

  resources :posts do
    resources :comments
    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")xx
  # root "articles#index"
end
