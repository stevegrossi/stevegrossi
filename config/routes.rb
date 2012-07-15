Stevegrossi::Application.routes.draw do

  match '/wishlist' => redirect('http://amzn.com/w/156EDXYQR8J2F')
  match '/made' => redirect('/built')
  match '/made/:slug' => redirect("/built/%{slug}")

  resources :users
  resources :books, :path => 'read' do
    collection do
      resources :authors
      get 'everything' => 'books#everything'
      get 'about' => 'books#topics'
      get 'about/:topic' => 'books#topic', :as => :tagged
    end
  end
  resources :writings, :path => 'wrote' do
    collection do
      get 'everything' => 'writings#everything'
    end
  end
  resources :works, :path => 'built' do
    collection do
      get 'everything' => 'works#everything'
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'
  get 'log_out' => 'sessions#destroy'
  match 'is' => 'pages#about', :as => 'about'
  match 'styleguide' => 'pages#styleguide'
  match 'colophon' => 'pages#colophon'
  match 'search' => 'pages#search'

  root :to => "pages#home"

  # 404 if route not recognized
  match '*a', :to => 'pages#error_404'

end
