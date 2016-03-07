Rails.application.routes.draw do





  get 'alumno/inicio'

  get 'empleados/show/:id' => 'empleados#show'

  get 'empleados/index'

  get 'empleados/new'

  get 'empleados/edit'
  get 'empleados/show'

  get 'admin/inicio'

  devise_for :empleados, :skip => [:registrations]
  as :empleado do
    get 'empleados/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
    put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  end



  #devise_for :empleados
  resources :empleados


  #devise_for :empleados, :controllers => { :registrations => "registrations" } , :skip => [:registrations]
  #as :empleado do
  #  get 'empleado/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
  #  put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  #end


  post "empleado/del/:id" => 'admin#elimUsr' , as: :elimUsr



  post "empleados/show/:id" => 'empleados#show', as: :showEmp


  root to: 'welcome#home', constraints: lambda { |request| !request.env['warden'].user }


  root to: 'admin#inicio', as: 'admin_root',
       constraints: lambda { |request| request.env['warden'].user.administrador? }

  root to: 'vendedor#inicio', as: 'vendedor_root',
       constraints: lambda { |request| request.env['warden'].user.profesor? }

  root to: 'alumno#inicio', as: 'alumno_root',
       constraints: lambda { |request| request.env['warden'].user.alumno? }

  #get 'welcome/home'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
 #root 'welcome#home'

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

  get "*any", via: :all, to: "errors#not_found"
end
