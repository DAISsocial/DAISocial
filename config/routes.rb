require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root :to => "static_pages#home", as: :authenticated
  end
  root :to => 'static_pages#landing'
  get 'help' => 'static_pages#help', as: :pdf
  get 'reports_page' => 'static_pages#reports', as: :reports
  get 'static_pages/download_docx/:id', to: 'static_pages#download_docx', as: 'load_docx'
  get 'home' => 'static_pages#home'
  resources :request_types, only: [:new, :create]
  resources :search_requests, only: [:new, :create]
  resources :check_requests, only: [:new, :create]
  resources :promocodes, only: [:new, :create]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
