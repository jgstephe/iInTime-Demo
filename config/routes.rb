Example::Application.routes.draw do
  root :to => 'pages#home'
  
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'
  match '/signup',    :to => 'users#new'
  match '/new',       :to => 'questions#new'
  match '/index',     :to => 'questions#index'
  match '/index/:id', :to => 'questions#index'
  match '/byuser',    :to => 'questions#qlist'
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :questions do
    get 'qlist', :on => :collection

    resources :responses, :only => [:create, :show]
    resources :ratings, :only => :create
    resources :comments, :only => :create
  end

end
