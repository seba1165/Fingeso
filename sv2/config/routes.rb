Rails.application.routes.draw do

  get '/cart' => 'cart#index'
  get '/cart/clear' => 'cart#clearCart'
  get '/cart/:id' => 'cart#add'
  get '/cart/rest/:id' => 'cart#rest'

  get '/cartart' => 'cartart#index'
  get '/cartart/clear' => 'cartart#clearCartArt'
  get '/cartart/:id' => 'cartart#add'
  get '/cartart/rest/:id' => 'cartart#rest'

  get 'sis_vehiculo_articulo/index'

  get 'sis_vehiculo_articulo/new'

  get 'sis_vehiculo_articulo/create'

  get 'sis_vehiculo_articulo/edit'

  get 'sis_vehiculo_articulo/update'

  get 'sis_vehiculo_articulo/destroy'

  get 'servs_inst/index'

  get 'servs_inst/new'

  get 'servs_inst/create'

  get 'servs_inst/edit'

  get 'servs_inst/update'

  get 'servs_inst/destroy'

  get 'modelos/index'

  get 'modelos/new'

  get 'modelos/create'

  get 'modelos/edit'

  get 'modelos/update'

  get 'modelos/destroy'

  get 'marcas/index'

  get 'marcas/new'

  get 'marcas/create'

  get 'marcas/edit'

  get 'marcas/update'

  get 'marcas/destroy'

  get 'herramientas/index'

  get 'herramientas/new'

  get 'herramientas/create'

  get 'herramientas/edit'

  get 'herramientas/update'

  get 'herramientas/destroy'

  get 'repuestos/index'

  get 'repuestos/new'

  get 'repuestos/create'

  get 'repuestos/edit'

  get 'repuestos/update'

  get 'repuestos/destroy'

  get 'insumos/index'

  get 'insumos/new'

  get 'insumos/create'

  get 'insumos/edit'

  get 'insumos/update'

  get 'insumos/destroy'

  get 'accesorios/index'

  get 'accesorios/new'

  get 'accesorios/create'

  get 'accesorios/edit'

  get 'accesorios/update'

  get 'accesorios/destroy'

  get 'tipos_articulo/index'

  get 'tipos_articulo/new'

  get 'tipos_articulo/edit'

  get 'articulos/index'

  get 'articulos/new'

  get 'articulos/edit'

  get 'servicio_reparaciones/index'

  get 'servicio_reparaciones/new'

  get 'servicio_reparaciones/edit'

  get 'articulos/index'

  get 'doc_previos/create'
  get 'doc_previos/new'
  get 'doc_previos/index'

  get 'vendedor/inicio'

  get 'cots_odc_art/index'

  get 'cots_odc_art/new'

  get 'cots_odc_art/show'

  get 'cots_odc_art/aprobar/:id' => 'cots_odc_art#aprobar'

  get 'clientes/index'

  get 'clientes/new'

  get 'clientes/edit'

  get 'tipos_cliente/index'

  get 'tipos_cliente/new'

  get 'tipos_cliente/edit'

  get 'empleados/index'

  get 'empleados/new'

  get 'empleados/edit'

  get 'admin/inicio'

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
  resources :tipos_cliente, :except => [:show]
  #resources :cots_odc_art, :except => [:show]
  resources :servicio_reparaciones, :except => [:show]
  #resources :cots_odc_art, :except => [:show]
  resources :doc_previos, :except => [:show]
  resources :articulos, :except => [:show]
  resources :accesorios, :except => [:show]
  resources :insumos, :except => [:show]
  resources :repuestos, :except => [:show]
  resources :herramientas, :except => [:show]
  resources :tipos_articulo, :except => [:show]
  resources :marcas, :except => [:show]
  resources :modelos, :except => [:show]
  resources :sis_vehiculo_articulo, :except => [:show]
  resources :servs_inst, :except => [:show]

  #devise_for :empleados, :controllers => { :registrations => "registrations" } , :skip => [:registrations]
  #as :empleado do
  #  get 'empleado/edit' => 'devise/registrations#edit', :as => 'edit_empleado_registration'
  #  put 'empleados' => 'devise/registrations#update', :as => 'empleado_registration'
  #end

  post "clientes/del/:id" => 'clientes#elimCliente' , as: :elimCliente
  post "empleado/del/:id" => 'admin#elimUsr' , as: :elimUsr
  #post "cots_odc_art/del/:id" => 'cots_odc_art#elimCotODCArt' , as: :elimCotODCArt
  post "tipos_cliente/del/:id" => 'tipos_cliente#elimTipoCliente', as: :elimTipoCliente
  post "doc_previos/del/:id" => 'doc_previos#elimDocPrevio', as: :elimDocPrevio
  post "servicio_reparaciones/del/:id" => 'servicio_reparaciones#elimSR', as: :elimSR
  post "articulos/del/:id" => 'articulos#elimArt', as: :elimArt
  post "tipos_articulo/del/:id" => 'tipos_articulo#elimTipoArt', as: :elimTipoArt
  post "marcas/del/:id" => 'marcas#elimMarca', as: :elimMarca
  post "accesorios/del/:id" => 'accesorios#elimAcc', as: :elimAcc
  post "herramientas/del/:id" => 'herramientas#elimHerr', as: :elimHerr
  post "insumos/del/:id" => 'insumos#elimIns', as: :elimIns
  post "repuestos/del/:id" => 'repuestos#elimRepu', as: :elimRepu
  post "modelos/del/:id" => 'modelos#elimModelo', as: :elimModelo

  post "cots_odc_art/del/:id" => 'cots_odc_art#elimCotODCArt', as: :elimCotODCArt

  post "cart/:id" => 'cart#add', as: :add
  post "cart/rest/:id" => 'cart#rest', as: :rest

  post "cartart/:id" => 'cartart#add', as: :addArt
  post "cartart/rest/:id" => 'cartart#rest', as: :restArt

  post "cots_odc_art/aprobar/:id" => 'cots_odc_art#aprobar', as: :aprobar

  post "sis_vehiculo_articulo/del/:id" => 'sis_vehiculo_articulo#elimSI', as: :elimSI

  get 'admin/parametro' => 'errors#construccion'

  get 'admin/registro'

  get 'vehiculos' => 'errors#construccion'

  get 'ventas' => 'errors#construccion'

  get 'precioArt' => 'errors#construccion'
  get 'precioServ' => 'errors#construccion'

  get 'admin/ordComp' => 'errors#construccion'

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

  get 'admin/articulo'

  get 'admin/servicio' => 'errors#construccion'

  get 'admin/servEdRep' => 'errors#construccion'
  
  get 'admin/servEdInstal' => 'errors#construccion'
  
  get 'vendedor/nuevaOC' => 'errors#construccion'

  get 'vendedor/anularOC' => 'errors#construccion'

  get 'vendedor/aprobarOC' => 'errors#construccion'

  get 'vendedor/abrirOC' => 'errors#construccion'

  get 'vendedor/ordComp' => 'errors#construccion'

  get 'vendedor/nuevaCot'

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

  root to: 'otros#inicio', as: 'jedeDeVentas_root',
       constraints: lambda { |request| request.env['warden'].user.jefeDeVentas? }
  root to: 'otros#inicio', as: 'jefeDeServicios_root',
       constraints: lambda { |request| request.env['warden'].user.jefeDeServicios? }
  root to: 'otros#inicio', as: 'jefeDeBodega_root',
       constraints: lambda { |request| request.env['warden'].user.jefeDeBodega? }

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
