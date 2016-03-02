class MarcasController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marcas = Marca.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marca = Marca.new();
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @marca_nombre = params[:marca][:marca_nombre];

      #Creamos el objeto con los valores a ingresar.
      @marca = Marca.new({
                                         :marca_nombre => @marca_nombre,
                                     });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @marca.save()
        redirect_to marcas_path, :notice => "La marca ha sido guardada con éxito";
      else
        render "new";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marca = Marca.find(params[:id]);
      @marca_nombre = @marca.marca_nombre;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marca_nombre = params[:marca]["marca_nombre"];

      @marca = Marca.find(params[:id]);
      @marca.marca_nombre = @marca_nombre;

      if @marca.save()
        redirect_to marcas_path, :notice => "La marca ha sido modificada";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marca = Marca.find(params[:id]);
      if @marca.destroy()
        redirect_to marcas_path, :notice => "La marca ha sido borrada";
      else
        redirect_to marcas_path, :notice => "La marca NO ha podido ser borrada";
      end
    end
  end

  def elimMarca
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @marca = Marca.find(params[:id]);
    end
  end
end