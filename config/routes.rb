Ggp2::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    get "sign_in" => "devise/sessions#new"
    delete "sign_out" => "devise/sessions#destroy"
  end

  resources :aggregates
  resources :matches
  resources :match_results, only: [:new, :create]
  resources :user_tips, only: :show
  resources :match_tips, only: :show
  resource :rankings, only: :show
  resources :teams
  resources :tips, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get :edit_multiple
      post :edit_multiple
      post :update_multiple
    end
  end
  resource :champion_tips, only: [:edit, :update]
  resources :venues

  # must be behind devise
  resources :users, except: [:show, :new]

  root :to => "matches#index"

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
