Rails.application.routes.draw do
  
  resources :blogs do
    resources :comments, only: [:create, :show]
    collection do       
      get :dev
      get :article
    end
  end
  resources :comments, only: [:destroy, :edit, :update]
  #resources :comments, only: [:edit, :update]
    
  
  resources :collections
  get 'users/profile'
  get 'closets/update'
  #get 'users/check'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmable:  'users/confirmations'
  }

  #get '/u/:id', to: 'users#profile', as: 'user'

  #resources :posts
  resources :brands
  resources :tags
  #root 'posts#index'
  root 'pages#index'
  
  get 'about'  => 'pages#about'
  get 'adroom' => 'pages#admin_room'
  post '/search', to: "search#search"

  get '/u/:id', to: 'users#profile', as: 'user'
  get 'setting' => 'users#setting'
  #get '/s/:id', to: 'users#setting', as: 'myuser'
  #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
  get 'posts/:id/visit', to: 'posts#visit', as: 'post_visit'
  post 'like/:id', to: 'posts#like', as: 'like_post'

  resources :posts do
    collection do
      post :check      
    end
    resources :comments, only: :create
    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")xxx
  # root "articles#index"
end
