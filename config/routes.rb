Recruiting::Application.routes.draw do
  resources :events do
    member do
      post :addUser
      post :removeUser
    end
  end

  resources :user_verifications
  #resources :infosessions, :controller => "events", :type => "Infosession"
  #resources :speakerpanels, :controller => "events", :type => "SpeakerPanel"
  #resources :careerfairs, :controller => "events", :type => "CareerFair"
  resources :users, :type => "User"
  resources :user_sessions
  get "verify", :controller => 'users', :action => 'verify'
  get "login", :controller => 'user_sessions', :action => 'new'
  get "logout", :controller => 'user_sessions', :action => 'destroy'
  #post "/events/:id/addUser", :controller => 'events', :action => 'addUser'
  get "/createRecruiter", :controller => 'users', :action => 'newRecruiter'
  post "/finishRecruiter", :controller => 'users', :action => 'finishRecruiter'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get "/home", :controller => 'events', :action => 'index'
  root 'users#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'  

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
