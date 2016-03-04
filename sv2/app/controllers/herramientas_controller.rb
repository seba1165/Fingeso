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

      @busqueda = Articulo.find_by(art_cod: @herramienta.art_cod)
      if @busqueda.nil?
        #Verificamos si la tarea ha podido ser guardado correctamente.
        if @herramienta.save()
          redirect_to articulos_path, :notice => "La herramienta ha sido guardado con éxito";
        else
          redirect_to articulos_path, :notice => "La herramienta no se pudo guardar";
        end
      else
        redirect_to articulos_path, :notice => "La herramienta con ese código ya existe en los artículos";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @herramienta = Herramienta.find(params[:id]);
      @art_cod = @herramienta.art_cod;
      @art_tipo_cod = @herramienta.art_tipo_cod;
      @art_nom = @herramienta.art_nom;
      @art_stock = @herramienta.art_stock;
      @art_precio = @herramienta.art_precio;
      @art_imagen = @herramienta.art_imagen;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @art_cod = params[:herramienta]["art_cod"];
      @art_tipo_cod = params[:herramienta]["art_tipo_cod"];
      @art_nom = params[:herramienta]["art_nom"];
      @art_stock = params[:herramienta]["art_stock"];
      @art_precio = params[:herramienta]["art_precio"];
      @art_imagen = params[:herramienta]["art_imagen"];

      @herramienta = Herramienta.find(params[:id]);
      @herramienta.art_cod = @art_cod;
      @herramienta.art_tipo_cod= @art_tipo_cod;
      @herramienta.art_nom = @art_nom;
      @herramienta.art_stock = @art_stock;
      @herramienta.art_precio = @art_precio;
      @herramienta.art_imagen = @art_imagen;


      if @herramienta.save()
        redirect_to articulos_path, :notice => "La herramienta ha sido modificada";
      else
        if @art_cod == ""
          redirect_to articulos_path, :notice => "La herramienta NO ha podido ser modificada";
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
      @herramienta = Articulo.find(params[:id]);
      if @articulo.destroy()
        redirect_to articulos_path, :notice => "La herramienta ha sido eliminada";
      else
        redirect_to articulos_path, :notice => "La herramienta NO ha podido ser eliminada";
      end
    end
  end
  def elimHerr
    @herramienta = Articulo.find(params[:id]);
  end
end
