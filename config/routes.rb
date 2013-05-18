Stevegrossi::Application.routes.draw do

  # Dynamic redirects
  get '/made/:slug' => redirect("/built/%{slug}")
  get '/wrote/:slug' => redirect("/on/%{slug}")
  get '/thoughts/:slug' => redirect("/on/%{slug}")
  get '/read/:slug' => redirect("/on/%{slug}")
  get '/read/authors/:slug' => redirect("/on/books/by/%{slug}")

  root to: redirect('/on')

  match '/404' => 'errors#error_404'
  match '/422' => 'errors#error_422'
  match '/500' => 'errors#error_500'

  namespace :meta do
    resources :books, :authors, :works, :redirects, :posts
    resources :pages, constraints: { id: /.*/ }
    root to: 'dashboard#home', as: :dashboard
  end

  resources :posts, path: 'on', only: [:index, :show] do
    collection do
      get 'page/:page', action: :index
      get 'topics' => 'posts#tags', as: :tags
      get 'topics/:slug' => 'posts#tag', as: :tagged
      resources :books, only: [:index, :show] do
        collection do
          resources :authors, only: [:index, :show], path: 'by'
        end
      end
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
