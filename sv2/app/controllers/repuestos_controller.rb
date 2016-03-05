class RepuestosController < ApplicationController
  include Devise::Controllers::Helpers
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
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @repuesto = Repuesto.find(params[:id]);
      @art_cod = @repuesto.art_cod;
      @art_tipo_cod = @repuesto.art_tipo_cod;
      @art_nom = @repuesto.art_nom;
      @art_stock = @repuesto.art_stock;
      @art_precio = @repuesto.art_precio;
      @art_imagen = @repuesto.art_imagen;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @art_cod = params[:repuesto]["art_cod"];
      @art_tipo_cod = params[:repuesto]["art_tipo_cod"];
      @art_nom = params[:repuesto]["art_nom"];
      @art_stock = params[:repuesto]["art_stock"];
      @art_precio = params[:repuesto]["art_precio"];
      @art_imagen = params[:repuesto]["art_imagen"];

      @repuesto = Repuesto.find(params[:id]);
      @repuesto.art_cod = @art_cod;
      @repuesto.art_tipo_cod= @art_tipo_cod;
      @repuesto.art_nom = @art_nom;
      @repuesto.art_stock = @art_stock;
      @repuesto.art_precio = @art_precio;
      @repuesto.art_imagen = @art_imagen;

      @art = Articulo.find(params[:id]);
      @art.art_cod = @art_cod;
      @art.art_tipo_cod= @art_tipo_cod;
      @art.art_nom = @art_nom;
      @art.art_stock = @art_stock;
      @art.art_precio = @art_precio;
      @art.art_imagen = @art_imagen;

      if @art.save() && @repuesto.save()
        redirect_to articulos_path, :notice => "El repuesto ha sido modificado";
      else
        if @art_cod == ""
          redirect_to articulos_path, :notice => "El repuesto NO ha podido ser modificado";
        else
          render "edit";
        end
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @repuesto = Repuesto.find(params[:id]);
      @art = Articulo.find(params[:id]);

      if @repuesto.destroy() && @art.destroy()
        redirect_to articulos_path, :notice => "El repuesto ha sido eliminado";
      else
        redirect_to articulos_path, :notice => "El repuesto NO ha podido ser eliminado";
      end
    end
  end
  def elimRepu
    @repuesto = Repuesto.find(params[:id]);
    @art = Articulo.find(params[:id]);

  end
end
