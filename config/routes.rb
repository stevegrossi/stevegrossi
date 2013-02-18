Stevegrossi::Application.routes.draw do

  get '/made' => redirect('/built')
  get '/made/:slug' => redirect("/built/%{slug}")

  root to: 'static_pages#home'

  namespace :meta do
    resources :books, :authors, :works, :writings, :redirects, :posts
    resources :pages, constraints: { id: /.*/ }, except: :show
    root to: 'dashboard#home', as: :dashboard
  end

  resources :users
  resources :posts, path: 'thoughts', only: [:index, :show] do
    collection do
      get 'page/:page', action: :index
      get 'about' => 'posts#topics', as: :topics
      get 'about/:topic' => 'posts#topic', as: :tagged
    end
  end
  resources :books, path: 'read', only: [:index, :show] do
    collection do
      resources :authors, only: [:index, :show]
    end
  end
  resources :writings, path: 'wrote', only: [:index, :show]
  resources :works, path: 'built', only: [:index, :show]

  get 'log_in' => 'sessions#new', as: 'log_in'
  post 'log_in' => 'sessions#create', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'search' => 'static_pages#search'
  get 'feed' => 'static_pages#feed', format: :rss

  get ':id', to: 'pages#show', as: :page, constraints: { id: /.*/ }

end
