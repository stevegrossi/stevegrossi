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

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # See how all your routes lay out with "rake routes"
end
