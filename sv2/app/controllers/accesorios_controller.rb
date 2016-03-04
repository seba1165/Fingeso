class AccesoriosController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @accesorios = Accesorio.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @accesorio = Accesorio.new
      @tipos = TipoArticulo.all
    end

  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las variables POST que vinieron desde la acción new.
      @art_cod = params[:accesorio][:art_cod];
      @art_tipo_cod = params[:accesorio][:art_tipo_cod];
      @art_nom = params[:accesorio][:art_nom];
      @art_stock = params[:accesorio][:art_stock];
      @art_precio = params[:accesorio][:art_precio];
      @art_imagen = params[:accesorio][:art_imagen];

      @accesorio = Accesorio.new({
                                   :art_cod => @art_cod,
                                   :art_tipo_cod => @art_tipo_cod,
                                   :art_nom => @art_nom,
                                   :art_stock => @art_stock,
                                   :art_precio => @art_precio,
                                   :art_imagen => @art_imagen,
                               });

      @busqueda = Articulo.find_by(art_cod: @accesorio.art_cod)
      if @busqueda.nil?
        #Verificamos si la tarea ha podido ser guardado correctamente.
        if @accesorio.save()
          redirect_to articulos_path, :notice => "El accesorio ha sido guardado con éxito";
        else
          redirect_to articulos_path, :notice => "El accesorio no se pudo guardar";
        end

      else
        redirect_to articulos_path, :notice => "El accesorio con ese código ya existe en los artículos";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @accesorio = Accesorio.find(params[:id]);
      @art_cod = @accesorio.art_cod;
      @art_tipo_cod = @accesorio.art_tipo_cod;
      @art_nom = @accesorio.art_nom;
      @art_stock = @accesorio.art_stock;
      @art_precio = @accesorio.art_precio;
      @art_imagen = @accesorio.art_imagen;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @art_cod = params[:accesorio]["art_cod"];
      @art_tipo_cod = params[:accesorio]["art_tipo_cod"];
      @art_nom = params[:accesorio]["art_nom"];
      @art_stock = params[:accesorio]["art_stock"];
      @art_precio = params[:accesorio]["art_precio"];
      @art_imagen = params[:accesorio]["art_imagen"];

      @accesorio = Accesorio.find(params[:id]);
      @accesorio.art_cod = @art_cod;
      @accesorio.art_tipo_cod= @art_tipo_cod;
      @accesorio.art_nom = @art_nom;
      @accesorio.art_stock = @art_stock;
      @accesorio.art_precio = @art_precio;
      @accesorio.art_imagen = @art_imagen;


      if @accesorio.save()
        redirect_to articulos_path, :notice => "El articulo ha sido modificado";
      else
        if @art_cod == ""
          redirect_to articulos_path, :notice => "El articulo NO ha podido ser modificado";
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
      @accesorio = Articulo.find(params[:id]);
      if @articulo.destroy()
        redirect_to articulos_path, :notice => "El artículo ha sido eliminado";
      else
        redirect_to articulos_path, :notice => "El artículo NO ha podido ser eliminado";
      end
    end
  end
  def elimAcc
    @accesorio = Articulo.find(params[:id]);
  end
end
