class InsumosController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @insumos = Insumo.all();
    end
  end

  def new
    @insumo = Insumo.new
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las variables POST que vinieron desde la acción new.
      @art_cod = params[:insumo][:art_cod];
      @art_tipo_cod = params[:insumo][:art_tipo_cod];
      @art_nom = params[:insumo][:art_nom];
      @art_stock = params[:insumo][:art_stock];
      @art_precio = params[:insumo][:art_precio];
      @art_imagen = params[:insumo][:art_imagen];

      @insumo = Insumo.new({
                                         :art_cod => @art_cod,
                                         :art_tipo_cod => @art_tipo_cod,
                                         :art_nom => @art_nom,
                                         :art_stock => @art_stock,
                                         :art_precio => @art_precio,
                                         :art_imagen => @art_imagen,
                                     });
      @busqueda = Articulo.find_by(art_cod: @insumo.art_cod)
      if @busqueda.nil?
        #Verificamos si la tarea ha podido ser guardado correctamente.
        if @insumo.save()
          redirect_to articulos_path, :notice => "El insumo ha sido guardado con éxito";
        else
          redirect_to articulos_path, :notice => "El insumo no se pudo  guardar";
        end
      else
        redirect_to articulos_path, :notice => "El insumo con ese código ya existe en los artículos";
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
