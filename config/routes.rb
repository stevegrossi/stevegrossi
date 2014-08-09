Stevegrossi::Application.routes.draw do

  # Dynamic redirects
  get '/built' => redirect("http://work.stevegrossi.com")
  get '/built/:slug' => redirect("http://work.stevegrossi.com")
  get '/wrote/:slug' => redirect("/on/%{slug}")
  get '/thoughts/about/:slug' => redirect("/on/topics/%{slug}")
  get '/thoughts/:slug' => redirect("/on/%{slug}")
  get '/read/:slug' => redirect("/on/%{slug}")
  get '/read/authors/:slug' => redirect("/on/books/by/%{slug}")

  root to: redirect('/on')

  get '/404' => 'errors#error_404'
  get '/422' => 'errors#error_422'
  get '/500' => 'errors#error_500'

  scope :meta do
    devise_for :users, skip: [:sessions, :registrations]
    as :user do
      get 'in' => 'devise/sessions#new', as: :new_user_session
      post 'in' => 'devise/sessions#create', as: :user_session
      get 'out' => 'devise/sessions#destroy', as: :destroy_user_session
    end
  end

  namespace :meta do
    resources :books do
      post 'finish' => 'books#finish'
    end
    resources :authors, :redirects, :posts
    resources :pages, constraints: { id: /.*/ }
    root to: 'dashboard#home', as: :dashboard
  end

  resources :posts, path: 'on', only: [:index, :show] do
    collection do
      get 'page/:page', action: :index, as: :paged
      get 'topics' => 'posts#tags', as: :tags
      get 'topics/:slug' => 'posts#tag', as: :tagged
      resources :books, only: [:index, :show] do
        collection do
          resources :authors, only: [:index, :show], path: 'by'
        end
      end
    end
  end

  get 'search' => 'static_pages#search'
  get 'feed' => 'static_pages#feed', defaults: { format: :rss }

  get ':id', to: 'pages#show', as: :page, constraints: { id: /.*/ }

end
