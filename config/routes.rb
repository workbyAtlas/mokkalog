Rails.application.routes.draw do
  resources :categories
  
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
  resources :discover
  #root 'posts#index'
  root 'pages#index'
  
  get 'about'  => 'pages#about'
  get 'adroom' => 'pages#admin_room'
  get 'faq' => 'pages#faq'
  get 'contact' => 'pages#contact'
  get 'mokkalog' => 'pages#mokkalog'
  
  get 'advsearch' => 'search#advsearch'
  post '/search', to: "search#search"

  get '/u/:id', to: 'users#profile', as: 'user'
  #get '/u/:username', to: 'users#profile', as: 'user_profile'

  get 'setting' => 'users#setting'
  #get '/s/:id', to: 'users#setting', as: 'myuser'
  #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
  get 'posts/:id/visit', to: 'posts#visit', as: 'post_visit'
  get 'posts/:id/quick', to: 'posts#quick', as: 'post_quick'
  post 'like/:id', to: 'posts#like', as: 'like_post'
  post 'favorite/:id', to: 'posts#favorite', as: 'favorite_post'

  resources :posts do
    collection do
      post :check  
    end

    resources :pagelinks
    resources :comments, only: :create
    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  end

  #resources :pagelinks, only: [:destroy, :edit, :update]

    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")xxx
  # root "articles#index"
end
