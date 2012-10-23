Stevegrossi::Application.routes.draw do

  namespace :meta do
    resources :books, :authors, :works, :writings
    root to: 'dashboard#home', as: :dashboard
  end

  match '/wishlist' => redirect('http://amzn.com/w/156EDXYQR8J2F')
  match '/made' => redirect('/built')
  match '/made/:slug' => redirect("/built/%{slug}")
  match '/resume' => redirect("/is/forhire")

  resources :users
  resources :books, path: 'read' do
    collection do
      resources :authors
      get 'about' => 'books#topics'
      get 'about/:topic' => 'books#topic', as: :tagged
    end
  end
  resources :writings, path: 'wrote'
  resources :works, path: 'built'

  resources :sessions, only: [:new, :create, :destroy]
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'
  get 'log_out' => 'sessions#destroy'
  match 'is' => 'pages#about', as: 'about'
  match 'is/forhire' => 'pages#resume', as: 'resume'
  match 'styleguide' => 'pages#styleguide'
  match 'colophon' => 'pages#colophon'
  match 'search' => 'pages#search'
  match 'feed' => 'pages#feed', format: :rss

  root to: "pages#home"

  # 404 if route not recognized
  match '*a', to: 'pages#error_404'

end
