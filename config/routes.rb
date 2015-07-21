PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new' # register_path
  get '/login', to: 'sessions#new' #login_path
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy' #logout_path

  resources :posts, except: :destroy do
    resources :comments, only: :create do
      member do
        post :vote # vote_post_comment_path	POST	/posts/:post_id/comments/:id/vote(.:format)	comments#vote
      end
    end

    member do
      post :vote # vote_post_path	POST	/posts/:id/vote(.:format)	posts#vote
    end
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:create, :edit, :update, :show]
end
