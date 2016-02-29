class TipoArticulosController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipoArticulos = TipoArticulo.all();
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipoArticulo = TipoArticulo.new();
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @tipoArticulo_nom = params[:tipo_articulo][:tipo_nom];

      #Creamos el objeto con los valores a ingresar.
      @tipoArticulo = TipoArticulo.new({
                                           :tipo_nom => @tipoArticulo_nom,
                                       });
      if @tipoArticulo.save()
        redirect_to tipo_articulos_path, :notice => "El tipo de articulo ha sido guardado con éxito";
      else
        render "new";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipoArticulo = TipoArticulo.find(params[:id]);
      @tipoArticulo_nom = @tipoArticulo.tipo_nom;
    else
      redirect_to '/errors/not_found'
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipo_nom = params[:tipo_articulo]["tipo_nom"];
      @tipoArticulo = TipoArticulo.find(params[:id]);
      @tipoArticulo.tipo_nom = @tipo_nom;

      if @tipoArticulo.save()
        redirect_to tipo_articulos_path, :notice => "El tipo de articulo ha sido modificado";
      else
        render "edit";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipoArticulo = TipoArticulo.find(params[:id]);
      @articulo = Articulo.find_by(art_tipo_cod: @tipoArticulo.art_tipo_cod)
      if @articulo.nil?
        if @tipoArticulo.destroy()
          redirect_to tipo_articulos_path, :notice => "El tipo de articulo ha sido eliminado";
        else
          redirect_to tipo_articulos_path, :notice => "El tipo de articulo NO ha podido ser eliminado";
        end
      else
        redirect_to tipo_articulos_path, :notice => "El tipo articulo no ha podido ser eliminado ya que tiene articulos asociados";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def elimTipoArt
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
      @tipoArticulo = TipoArticulo.find(params[:id]);
    else
      redirect_to '/errors/not_found'
    end
  end
end
