Stevegrossi::Application.routes.draw do

  resources :users
  resources :books, :path => 'read'
  resources :writings, :path => 'wrote'
  resources :works, :path => 'made'

  resources :sessions, :only => [:new, :create, :destroy]
  get 'log_in' => 'sessions#new'
  post 'log_in' => 'sessions#create'
  get 'log_out' => 'sessions#destroy'
  match 'is' => 'pages#about', :as => 'about'
  match 'colophon' => 'pages#colophon'

  root :to => "pages#home"

  # 404 if route not recognized
  # needed until 'rescue_from ActionController::RoutingError' gets fixed in 3.1
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
