Mywebsite::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#auth"
  resources :messages, only: [:create, :index]
  resources :links, only: [:index]
  resources :sessions,  only: [:new, :create, :destory]

  get "account/advanced"
  get "account/icon"
  get "account/profile"
  post "account/update_pro"
  post "account/update_adv"
  get "home/index"
  match '/(page/:page)' => 'home#index', constraints: { page: /\d+/}
  root  to: 'home#index', as: :root

  resources :comments, only: [:index, :create]
  resources :subscribes, only: [:create, :destroy]

  resources :blogs, only: [:index, :show] do
    collection do
      get "user_like"
      post "add_category"
    end
  end

  resources :users, except: [:edit, :update] do
    collection do
      get "success"
      get "activate"
    end
  end
  match '/register',  to: 'users#new',          via: 'get'
  match '/login',     to: 'sessions#new',       via: 'get'
  match '/logout',    to: 'sessions#destroy',   via: 'get'

  match 'about',  to: 'pages#about', as: :about
  match 'resume', to: 'pages#resume', as: :resume
  match 'xingge', to: 'pages#xingge', as: :xingge
  match 'api',    to: 'pages#api', as: :api

  scope 'cn' do
    get 'blogs'       =>  'api/blogs#index'
    get "blogs/:id"   =>  'api/blogs#show'
    get 'categories'  =>  'api/blogs#categories'
    get 'home'        =>  'api/home#index'
    get 'nav'         =>  'api/home#nav'
    get 'links'       =>  'api/links#index'
    post 'subscribes' =>  'api/subscribes#create'
    get 'messages'    =>  'api/messages#index'
  end

  namespace 'admin' do
    get '/' => 'blogs#index'
    resources :blogs, except: [:destroy] do
      member do
        post "toggle_publish_status"
      end
    end
    resources :messages, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :links, except: [:show]
    resources :blog_categories
    resources :link_categories, only: [:index, :new, :create]
    resources :tips
    resources :subscribes, only: [:index, :destroy]
  end

  # gem kindeditor upload routes
  namespace :kindeditor do
    post "/upload" => "assets#create"
    get  "/filemanager" => "assets#list"
  end

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
  # match ':controller(/:action(/:id))(.:format)'

  %w(404 422 500).each do |code|
      get code, to: "errors#show", code: code
  end
  # match '*path' => redirect('/404.html')
  match "*path" => "errors#404"
end
