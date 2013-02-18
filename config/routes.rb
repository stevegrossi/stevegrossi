Stevegrossi::Application.routes.draw do

  get '/made' => redirect('/built')
  get '/made/:slug' => redirect("/built/%{slug}")
  get '/read' => redirect('/thoughts')
  get '/read/:slug' => redirect("/thoughts/%{slug}")
  get '/wrote' => redirect('/thoughts')
  get '/wrote/:slug' => redirect("/thoughts/%{slug}")

  root to: redirect('/thoughts')

  namespace :meta do
    resources :books, :authors, :works, :redirects, :posts
    resources :pages, constraints: { id: /.*/ }, except: :show
    root to: 'dashboard#home', as: :dashboard
  end

  resources :posts, path: 'thoughts', only: [:index, :show] do
    collection do
      get 'page/:page', action: :index
      get 'about' => 'posts#topics', as: :topics
      get 'about/:topic' => 'posts#topic', as: :tagged
    end
  end
  resources :books, only: [:index, :show] do
    collection do
      resources :authors, path: 'by', only: [:index, :show]
    end
  end
  resources :works, path: 'built', only: [:index, :show]
  resources :users

  get 'log_in' => 'sessions#new', as: 'log_in'
  post 'log_in' => 'sessions#create', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'search' => 'static_pages#search'
  get 'feed' => 'static_pages#feed', format: :rss

  get ':id', to: 'pages#show', as: :page, constraints: { id: /.*/ }

end
