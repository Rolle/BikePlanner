Bikeplanner::Application.routes.draw do
  resources :groups

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "sessions/changelog"
  get "sessions/imprint"

  post "comments/withouttour"

  match '/signout', :to => 'sessions#destroy', via: :get
  match '/signin', :to => 'sessions#new', via: :get
  match '/user_list', :to => 'users#index', via: :get
  match '/all', :to => 'tours#index', via: :get
  match '/changelog', :to => 'sessions#changelog', via: :get
  match '/imprint', :to => 'sessions#imprint', via: :get
  
  match "/month" => "tours#month", via: :get
  match "tours/month/:year/:month"     => "tours#month", :as => "tour_calendar", via: :get

  match "/calendar_month" => "calenders#month", via: :get
  match "calenders/month/:year/:month" => "calenders#month", :as => "event_calendar", via: :get
  
  match 'group/:user_id/:group_id' => 'users#change_group', :as => :change_group, via: :get

  resources :tours do
    member do
      get 'add'
      get 'cancel'
      #post 'close'
    end
    collection do
      get 'week'
      get 'own'
      get 'month'
      get 'notclosed'
      get 'tracks'
    end
  end
  match 'tours/:id/close' => 'tours#close', :as => :close, via: :patch
  resources :tracks do
    collection do
      get 'mtb'
      get 'rr'
    end
  end

  resources :tracks
  resources :posts
  resources :tours
  resources :users

  resources :comments do
    member do
      put 'withouttour'
    end
  end
  #resources :comments

  resources :ratings    

  resources :statistics do
    collection do
      get 'tour'
      get 'user'
      get 'diary'
    end
  end
  resources :statistics
  
  resources :calenders do
    collection do
        get 'month'
    end
  end
  resources :calenders
  resources :sessions , :only => [:new, :create, :destroy, :group]

  #scope "(:locale)", :locale => /en|de/ do
    root :to => 'tours#month'
    #get "page/index"
  #end

  #root :to => 'tours#month'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

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

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
