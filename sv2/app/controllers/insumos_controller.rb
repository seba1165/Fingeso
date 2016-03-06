class InsumosController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @insumos = Insumo.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @insumo = Insumo.new
      @tipos = TipoArticulo.all
    end
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
          render "new"
        end
      else
        redirect_to articulos_path, :notice => "El insumo con ese código ya existe en los artículos";
      end
    end
  end

def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @insumo = Insumo.find(params[:id]);
      @art_cod = @insumo.art_cod;
      @art_tipo_cod = @insumo.art_tipo_cod;
      @art_nom = @insumo.art_nom;
      @art_stock = @insumo.art_stock;
      @art_precio = @insumo.art_precio;
      @art_imagen = @insumo.art_imagen;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @art_cod = params[:insumo]["art_cod"];
      @art_tipo_cod = params[:insumo]["art_tipo_cod"];
      @art_nom = params[:insumo]["art_nom"];
      @art_stock = params[:insumo]["art_stock"];
      @art_precio = params[:insumo]["art_precio"];
      @art_imagen = params[:insumo]["art_imagen"];

      @insumo = Insumo.find(params[:id]);
      @insumo.art_cod = @art_cod;
      @insumo.art_tipo_cod= @art_tipo_cod;
      @insumo.art_nom = @art_nom;
      @insumo.art_stock = @art_stock;
      @insumo.art_precio = @art_precio;
      @insumo.art_imagen = @art_imagen;

      @art = Articulo.find(params[:id]);
      @art.art_cod = @art_cod;
      @art.art_tipo_cod= @art_tipo_cod;
      @art.art_nom = @art_nom;
      @art.art_stock = @art_stock;
      @art.art_precio = @art_precio;
      @art.art_imagen = @art_imagen;

      if @art.save() && @insumo.save()
        redirect_to articulos_path, :notice => "El insumo ha sido modificado";
      else
        if @art_cod == ""
          redirect_to articulos_path, :notice => "El insumo NO ha podido ser modificado";
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
      @insumo = Insumo.find(params[:id]);
      @art = Articulo.find(params[:id]);

      if @insumo.destroy() && @art.destroy() 
        redirect_to articulos_path, :notice => "El artículo ha sido eliminado";
      else
        redirect_to articulos_path, :notice => "El artículo NO ha podido ser eliminado";
      end
    end
  end
  def elimIns
    @insumo = Insumo.find(params[:id]);
    @art = Articulo.find(params[:id]);
  end
end
