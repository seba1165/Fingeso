Rails.application.routes.draw do

  get 'articulos/index'

  get 'articulos/new'

  get 'articulos/edit'

  get 'servicio_reparacions/index'

  get 'servicio_reparacions/new'

  get 'servicio_reparacions/edit'

  get 'cot_odc_arts/index'

  get 'cot_odc_arts/new'

  get 'cot_odc_arts/edit'

  get 'clientes/index'

  get 'clientes/new'

  get 'clientes/edit'

  get 'tipo_clientes/index'

  get 'tipo_clientes/new'

  get 'tipo_clientes/edit'

  get 'empleados/index'

  get 'empleados/new'

  get 'empleados/edit'

  get 'admin/inicio'

  get 'vendedor/inicio' => 'errors#construccion'

  devise_for :empleados, :skip => [:registrations]
  as :empleado do
    get 'empleados/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
    put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  end

  resources :clientes, :except => [:show] do
    collection do
      get :autocomplete_cliente_cliente_correo
    end
  end

  #devise_for :empleados
  resources :empleados, :except => [:show]

  resources :tipo_clientes, :except => [:show]

  resources :servicio_reparacions, :except => [:show]

  resources :cot_odc_arts, :except => [:show]

  resources :doc_previos, :except => [:show]

  resources :articulos, :except => [:show]

  #devise_for :empleados, :controllers => { :registrations => "registrations" } , :skip => [:registrations]
  #as :empleado do
  #  get 'empleado/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
  #  put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  #end

  post "clientes/del/:id" => 'clientes#elimCliente' , as: :elimCliente
  post "empleado/del/:id" => 'admin#elimUsr' , as: :elimUsr

  post "cot_odc_arts/del/:id" => 'cot_odc_arts#elimCotODCArt' , as: :elimCotODCArt
  post "tipo_clientes/del/:id" => 'tipo_clientes#elimTipoCliente', as: :elimTipoCliente
  post "servicio_reparacions/del/:id" => 'servicio_reparacions#elimSR', as: :elimSR
  post "articulos/del/:id" => 'articulos#elimArt', as: :elimArt

  get 'admin/cotPrev'

  get 'admin/cotFinal'

  get 'admin/parametro' => 'errors#construccion'

  get 'admin/registro'

  get 'admin/cotAgHerr' 

  get 'admin/cotAgRepto'

  get 'admin/cotAgAcc'

  get 'admin/cotAgRepar'

  get 'admin/cotAgIns'

  get 'admin/cotAgInstal'

  get 'admin/agregUsr'

  get 'admin/editUsr'

  get 'admin/elimUsr'

  get 'admin/nCotAgregArt'

  get 'admin/nCotAgregSer'

  get 'admin/cotizacion'

  get 'admin/nuevCot'
  
  get 'admin/cotNuevAgreg'

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

  get 'admin/articulo' => 'errors#construccion'

  get 'admin/servicio'

  get 'admin/servEdRep'
  
  get 'admin/servEdInstal'
  
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
