class HerramientasController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @herramientas = Herramienta.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @herramienta = Herramienta.new
      @tipos = TipoArticulo.all
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las variables POST que vinieron desde la acción new.
      @art_cod = params[:herramienta][:art_cod];
      @art_tipo_cod = params[:herramienta][:art_tipo_cod];
      @art_nom = params[:herramienta][:art_nom];
      @art_stock = params[:herramienta][:art_stock];
      @art_precio = params[:herramienta][:art_precio];
      @art_imagen = params[:herramienta][:art_imagen];

      @herramienta = Herramienta.new({
                                     :art_cod => @art_cod,
                                     :art_tipo_cod => @art_tipo_cod,
                                     :art_nom => @art_nom,
                                     :art_stock => @art_stock,
                                     :art_precio => @art_precio,
                                     :art_imagen => @art_imagen,
                                 });


      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @herramienta.save()
        redirect_to articulos_path, :notice => "La herramienta ha sido guardado con éxito";
      else
        redirect_to articulos_path, :notice => "La herramienta no se pudo  guardar";
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
