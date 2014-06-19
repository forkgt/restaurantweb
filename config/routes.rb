Ibm::Application.routes.draw do

  resources :subscriptions, :templates, :cartridges
  resources :addresses
  resources :cart_items
  resources :carts do
    member do
      get :delivery_type
    end
  end

  resources :stores do
    resources :menus, :coupons, :orders, :payments, :statements, :dish_choices, :dish_features
  end

  resources :menus do
    resources :categories
  end

  resources :categories do
    resources :dishes
  end

  resources :statements do
    resources :statement_items
  end

  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "h/user_manager", "h/retrieve_store"

  get "q/index", "q/missing", "q/closed", "q/store_order_success", "q/store_order_failure", "q/store_order_cancel", "q/paypal_notify"
  get "q/store_home",        to: "q#store_home",        as: "q_store_home"
  get "q/store_menus",       to: "q#store_menus",       as: "q_store_menus"
  get "q/store_map",         to: "q#store_map",         as: "q_store_map"

  root 'q#index'

  # ============= Deal with Subdomain ===============

  #require 'subdomain' # File in lib
  #constraints(Subdomain) do
  #  get '/', to: "q#store_home"
  #end

  # =================================================





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
