Stevegrossi::Application.routes.draw do

  resources :users
  resources :books, :path => 'read' do
    collection do
      match 'everything' => 'books#everything'
    end
  end
  resources :writings, :path => 'wrote' do
    collection do
      match 'everything' => 'writings#everything'
    end
  end
  resources :works, :path => 'made' do
    collection do
      match 'everything' => 'works#everything'
    end
  end
  resources :wishlist_items, :path => 'wishlist'

  resources :sessions, :only => [:new, :create, :destroy]
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'
  get 'log_out' => 'sessions#destroy'
  match 'is' => 'pages#about', :as => 'about'
  match 'colophon' => 'pages#colophon'

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
