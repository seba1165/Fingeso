class ArticulosController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @articulo = Articulo.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @articulo = Articulo.new();
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @articulo_cod = params[:articulo][:art_cod];
      @articulo_tipo_cod = params[:articulo][:art_tipo_cod];
      @articulo_nom = params[:articulo][:art_nom];
      @articulo_stock = params[:articulo][:art_stock];
      @articulo_precio = params[:articulo][:art_precio];
      @articulo_imagen = params[:articulo][:art_imagen];

      #Creamos el objeto con los valores a ingresar.
      @articulo = Articulo.new({
                                 :art_cod => @articulo_cod,
                                 :art_tipo_cod => @articulo_tipo_cod,
                                 :art_nom => @articulo_nom,
                                 :art_stock => @articulo_stock,
                                 :art_precio => @articulo_precio,
                                 :art_imagen => @articulo_imagen,
                             });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @articulo.save()
        redirect_to articulos_path, :notice => "El Artículo ha sido guardado con éxito";
      else
        render "new";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @articulo = Articulo.find(params[:id]);
      @articulo_cod = @articulo.art_cod;
      @articulo_tipo_cod = @articulo.art_tipo_cod;
      @articulo_nom = @articulo.art_nom;
      @articulo_stock = @articulo.art_stock;
      @articulo_precio = @articulo.art_precio;
      @articulo_imagen = @articulo.art_imagen;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @articulo_cod = params[:articulo]["art_cod"];
      @articulo_tipo_cod = params[:articulo]["art_tipo_cod"];
      @articulo_nom = params[:articulo]["art_nom"];
      @articulo_stock = params[:articulo]["art_stock"];
      @articulo_precio = params[:articulo]["art_precio"];
      @articulo_imagen = params[:articulo]["art_imagen"];

      @articulo = Articulo.find(params[:id]);
      @articulo.art_cod = @articulo_cod;
      @articulo.art_tipo_cod= @articulo_tipo_cod;
      @articulo.art_nom = @articulo_nom;
      @articulo.art_stock = @articulo_stock;
      @articulo.art_precio = @articulo_precio;
      @articulo.art_imagen = @articulo_imagen;


      if @articulo.save()
        redirect_to articulos_path, :notice => "El articulo ha sido modificado";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @articulo = Articulo.find(params[:id]);
      if @articulo.destroy()
        redirect_to articulos_path, :notice => "El artículo ha sido eliminado";
      else
        redirect_to articulos_path, :notice => "El artículo NO ha podido ser eliminado";
      end
    end
  end
  def elimArt
    @articulo = Articulo.find(params[:id]);
  end
end
