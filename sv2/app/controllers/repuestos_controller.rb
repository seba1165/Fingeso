class RepuestosController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @repuestos = Repuesto.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @repuesto = Repuesto.new
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las variables POST que vinieron desde la acción new.
      @art_cod = params[:repuesto][:art_cod];
      @art_tipo_cod = params[:repuesto][:art_tipo_cod];
      @art_nom = params[:repuesto][:art_nom];
      @art_stock = params[:repuesto][:art_stock];
      @art_precio = params[:repuesto][:art_precio];
      @art_imagen = params[:repuesto][:art_imagen];

      @repuesto = Repuesto.new({
                                         :art_cod => @art_cod,
                                         :art_tipo_cod => @art_tipo_cod,
                                         :art_nom => @art_nom,
                                         :art_stock => @art_stock,
                                         :art_precio => @art_precio,
                                         :art_imagen => @art_imagen,
                                     });
      @busqueda = Articulo.find_by(art_cod: @repuesto.art_cod)
      if @busqueda.nil?
        #Verificamos si la tarea ha podido ser guardado correctamente.
        if @repuesto.save()
          redirect_to articulos_path, :notice => "El repuesto ha sido guardado con éxito";
        else
          redirect_to articulos_path, :notice => "El repuesto no se pudo  guardar";
        end
      else
        redirect_to articulos_path, :notice => "El repuesto con ese código ya existe en los artículos";
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
