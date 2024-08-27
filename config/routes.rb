Rails.application.routes.draw do
  root 'pages#about'
  #root 'pages#merry'
  get 'merry' => 'pages#merry'
  get 'home' => 'posts#home'
  get 'pic' => 'posts#pic'
  get 'archive' => 'posts#archive'

  #TEST
  get 'payment' => 'pages#payment'




  
  resources :brand_onboarding
  resources :after_sign_up
  resources :styles
  resources :categories
  resources :tags
  resources :activities
  resources :collections do
    member do
      post :like
    end
  end
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
      post :like
      get :analysis
    end
  end
  
  

  get 'users/profile'



  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmable:  'users/confirmations'
  }
  get '/u/:id', to: 'users#profile', as: 'user'
  get 'setting'   => 'users#setting'
  #get 'dashboard' => 'users#dashboard'
  get '/dashboard/:id', to: 'users#dashboard', as: 'dashboard'
  get '/coin/:id', to: 'users#coin', as: 'coin'

  #PAGES  
  get 'about'     => 'pages#about'
  get 'badges'    => 'pages#badges'
  get 'guideline' => 'pages#guideline'
  get 'discover'  => 'pages#index'
  get 'faq'       => 'pages#faq'
  get 'contact'   => 'pages#contact'

  get 'mokkalabbo'  => 'pages#mokkalab'
  get 'mokkalab' => 'molla#index'


  get 'test' => 'molla#test'
  post 'molla/talk', to: 'molla#talk'
  post 'molla/new_chat', to: 'molla#new_chat'
  get 'molla/select_chat/:id', to: 'molla#select_chat', as: 'select_chat'
  get 'molla/delete_chat/:id', to: 'molla#destroy', as: 'delete_chat'





  #ONBOARDING
  get 'welcome'              => 'onboarding#step1'
  get 'brand_owner'          => 'onboarding#brand'
  get 'payment_plan'         => 'onboarding#brand_plan'
  get 'browse'               => 'onboarding#browse'

  get 'adroom'    => 'pages#admin_room'
  get 'mokkalog'  => 'pages#mokkalog'
  get 'manage'    => 'pages#manage'
  get 'lockdown'  => 'pages#lockdown'
  get 'demo'      => 'pages#demo'

  get 'database'  => 'admin#data'
  get 'branddata' => 'admin#brand_data'
  get 'admin' => 'admin#index'



  resources :posts do
    collection do
      post :check

    end
    
    member do
      post :like
      get :visit
      get :visitmodal

    end
      
    
    resources :pagelinks
    resources :comments, only: :create
    #get 'posts/:id/visit', to: 'posts#visit', as: 'visit_post'
    #get "visit"
  end

  #post 'like/:id', to: 'posts#like', as: 'like_post'
  post 'favorite/:id', to: 'posts#favorite', as: 'favorite_post'

  #resources :pagelinks, only: [:destroy, :edit, :update]

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")xxx
  # root "articles#index"
end
