PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new' # register_path
  get '/login', to: 'sessions#new' #login_path
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy' #logout_path

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create]
end
