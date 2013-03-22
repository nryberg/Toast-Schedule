ToastSchedule::Application.routes.draw do

  match 'about' => 'welcome#about', :as => :about
  match 'pricing' => 'welcome#pricing', :as => :pricing
  match 'welcome/register' => 'welcome#register'
  match 'welcome/newmember' => 'welcome#newmember'
  match 'welcome/newclub' => 'welcome#newclub'
  match 'members/search' => 'members#search'
  match 'members/validate' => 'members#validate'
  match 'members/validate_me/:id' => 'members#validate_me'
  match 'clubs/search' => 'clubs#search'
  match 'nominate_officer' => 'memberships#nominate_officer', :as => :nominate_officer_form, :via => [:get, :post]

  match 'roles/up/:id' => 'roles#up'
  match 'roles/down/:id' => 'roles#down'
  match 'clubs/:id/billings/new' => 'billings#new', :via => [:post, :get]

  resources :memberships
  resources :password_resets

  resources :roles
  match 'billings/confirm_payment' => 'billings#confirm'
  resources :billings 

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

   resources :role_types
  

   resources :clubs do
     resources :meetings
     resources :templates
     resources :memberships
   end
  
   
   resources :members do
    get :search, :collection
     resources :clubs
     resources :memberships
   end
   
   resources :meetings do
     resources :roles
   end

   resources :templates do
     resources :plates
     get 'editplates' => :editplates
   end
   
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
  root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
