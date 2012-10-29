Stevegrossi::Application.routes.draw do

  namespace :meta do
    resources :books, :authors, :works, :writings
    root to: 'dashboard#home', as: :dashboard
  end

  get '/wishlist' => redirect('http://amzn.com/w/156EDXYQR8J2F')
  get '/made' => redirect('/built')
  get '/made/:slug' => redirect("/built/%{slug}")
  get '/resume' => redirect("/is/forhire")

  resources :users
  resources :books, path: 'read', only: [:index, :show] do
    collection do
      resources :authors, only: [:index, :show]
      get 'about' => 'books#topics'
      get 'about/:topic' => 'books#topic', as: :tagged
    end
  end
  resources :writings, path: 'wrote', only: [:index, :show]
  resources :works, path: 'built', only: [:index, :show]

  resources :sessions, only: [:new, :create, :destroy]
  get 'log_in' => 'sessions#new', as: 'log_in'
  post 'log_in' => 'sessions#create', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'is' => 'pages#about', as: 'about'
  get 'is/forhire' => 'pages#resume', as: 'resume'
  get 'styleguide' => 'pages#styleguide'
  get 'colophon' => 'pages#colophon'
  get 'search' => 'pages#search'
  get 'feed' => 'pages#feed', format: :rss

  root to: "pages#home"

  # 404 if route not recognized
  match '*a', to: 'pages#error_404'

end
