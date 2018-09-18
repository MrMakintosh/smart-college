Rails.application.routes.draw do
  get 'student/index'

  get 'student/new'

  get 'student/edit'

  get 'group/index'

  get 'group/new'

  get 'group/edit'

  get 'specialty/index'

  get 'specialty/new'

  get 'departments/index'

  get '/api_request/:id/:date_of/:date_for', to: 'student#api_request'

  get '/add_pass/:student/:affirmative_hours/:negative_hours/:date_of/:date_for', to: 'passes#add_pass'

  get '/search/:term', to: 'student#search'

  get '/users/ratings', to: 'users#ratings', as: 'ratings'

  get '/passes/index'

  post 'specialties', to: 'specialty#create'
  post 'groups', to: 'group#create'
  post 'students', to: 'student#create'

  root 'welcome_page#index'

  get 'users/profile', to: 'users#profile', as: 'person_root'

  resources :departments
  resources :specialty
  resources :group
  resources :student

  resources :users

  resources :user_sessions, only: [:create, :destroy]

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in




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
