HomeSquare::Application.routes.draw do

  resources :searches

  get "residents/index"
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get 'like', to: 'users#like'
  get 'unlike', to: 'users#unlike'
  
  resources :cities

  resources :neighborhoods do
    resources :posts
    resources :groups
    resources :events
    resources :residents, :only => [:index]
  end

  resources :apartments do
    resources :posts
    resources :residents, :only => [:index]
  end

  resources :groups do
    resources :posts
  end
  
  resources :events do
    resources :posts
  end

  resources :posts do
    resources :comments, :only => [:create, :destroy]
  end
  
  # resources :locations

  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get "pages/home"
  get "pages/about"
  get "pages/privacy"
  get "pages/terms"
  get "pages/faq"
  get "pages/careers"
  get "pages/media"
  get "pages/contact"
  get "pages/search"
  get "pages/populate"

  authenticated :user do
    root :to => "posts#index", as:  :authenticated_root
  end
  
  unauthenticated do
    root :to => "pages#home"
  end

  devise_for :users, :controllers => {:registrations => "registrations", confirmations: "confirmations", :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get "register", :to => "devise/registrations#new", :as => :register
    get "login", :to => "devise/sessions#new", :as => :login
    get "logout", :to => "devise/sessions#destroy", :as => :logout
  end
  
  resources :users

end