Rails.application.routes.draw do


  get 'empleados/index'

  get 'empleados/new'

  get 'empleados/create'

  get 'empleados/edit'

  get 'empleados/update'

  get 'empleados/destroy'

  devise_for :empleados, :skip => [:registrations]
  as :empleado do
    get 'empleados/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
    put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  end

  #devise_for :empleados
  resources :empleados, :except => [:show]

  #devise_for :empleados, :controllers => { :registrations => "registrations" } , :skip => [:registrations]
  #as :empleado do
  #  get 'empleado/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
  #  put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  #end

  post "empleado/del/:id" => 'admin#elimUsr' , as: :elimUsr

  get 'admin/cotPrev'

  get 'admin/cotFinal'

  get 'admin/parametro' => 'errors#construccion'

  get 'admin/registro' => 'errors#construccion'

  get 'admin/cotAgHerr' 

  get 'admin/cotAgRepto'

  get 'admin/cotAgAcc'

  get 'admin/cotAgRepar'

  get 'admin/cotAgIns'

  get 'admin/agregUsr'

  get 'admin/editUsr'

  get 'admin/elimUsr'

  get 'admin/nCotAgregArt' => 'admin#nCotAgregArt'

  get 'admin/cotizacion'

  get 'admin/nuevCot'

  get 'admin/anularCot'

  get 'admin/aprobCot'

  get 'admin/abrirCot'

  get 'admin/ordComp'

  get 'admin/nuevaOC' => 'errors#construccion'

  get 'admin/anularOC' => 'errors#construccion'

  get 'admin/aprobOC' => 'errors#construccion'

  get 'admin/abrirOC' => 'errors#construccion'

  get 'admin/OT' => 'errors#construccion'

  get 'admin/anularOT' => 'errors#construccion'

  get 'admin/editarOT' => 'errors#construccion'

  get 'admin/finOT' => 'errors#construccion'

  get 'admin/notVent' => 'errors#construccion'

  get 'admin/genNV' => 'errors#construccion'

  get 'admin/pagoNV' => 'errors#construccion'

  get 'admin/inicio'

  get 'vendedor/nuevaOC' => 'errors#construccion'

  get 'vendedor/anularOC' => 'errors#construccion'

  get 'vendedor/aprobarOC' => 'errors#construccion'

  get 'vendedor/abrirOC' => 'errors#construccion'

  get 'vendedor/ordComp' => 'errors#construccion'

  get 'vendedor/nuevaCot' => 'errors#construccion'

  get 'vendedor/anular' => 'errors#construccion'

  get 'vendedor/aprobar' => 'errors#construccion'

  get 'vendedor/abrir' => 'errors#construccion'

  get 'vendedor/cotizacion' => 'errors#construccion'

  get 'vendedor/notVen' => 'errors#construccion'

  get 'vendedor/inicio' => 'errors#construccion'

  get 'vendedor/clientes' => 'errors#construccion'

  get 'vendedor/vehiculos' => 'errors#construccion'

  root to: 'welcome#home', constraints: lambda { |request| !request.env['warden'].user }

  root to: 'admin#inicio', as: 'admin_root',
       constraints: lambda { |request| request.env['warden'].user.administrador? }

  root to: 'vendedor#inicio', as: 'vendedor_root',
       constraints: lambda { |request| request.env['warden'].user.vendedor? }


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
