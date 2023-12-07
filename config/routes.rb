Rails.application.routes.draw do
  root 'pages#about'
  get 'home' => 'posts#home'
  
  resources :styles
  resources :categories
  resources :tags
  resources :collections
  resources :comments, only: [:destroy, :edit, :update]
  resources :blogs do
    resources :comments, only: [:create, :show]
    collection do       
      get :dev
      get :article
    end
  end

  resources :brands do
    member do
      delete :purge_banner
    end
  end
  
  

  get 'users/profile'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmable:  'users/confirmations'
  }
  get '/u/:id', to: 'users#profile', as: 'user'
  get 'setting' => 'users#setting'

  #PAGES  
  get 'about'     => 'pages#about'
  get 'badges'    => 'pages#badges'
  get 'guideline' => 'pages#guideline'
  get 'discover'  => 'pages#index'
  get 'faq'       => 'pages#faq'
  get 'contact'   => 'pages#contact'
  #ONBOARDING
  get 'confirmation_pending' => 'pages#after_sign'
  get 'welcome'              => 'pages#induction'
  get 'brand_onboarding'     => 'pages#brand_onboarding'

  get 'adroom'    => 'pages#admin_room'
  get 'mokkalog'  => 'pages#mokkalog'
  get 'manage'    => 'pages#manage'
  get 'lockdown'  => 'pages#lockdown'

  #get 'posts/:id/visit', to: 'posts#visit', as: 'post_visit'
  #get 'posts/:id/quick', to: 'posts#quick', as: 'post_quick'


  resources :posts do
    collection do
      post :check  
    end
    resources :pagelinks
    resources :comments, only: :create
    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  end

  post 'like/:id', to: 'posts#like', as: 'like_post'
  post 'favorite/:id', to: 'posts#favorite', as: 'favorite_post'

  #resources :pagelinks, only: [:destroy, :edit, :update]

    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")xxx
  # root "articles#index"
end
