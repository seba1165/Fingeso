class MarcasController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marcas = Marca.all();
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca = Marca.new();
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
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
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca = Marca.find(params[:id]);
      @marca_nombre = @marca.marca_nombre;
    else
      redirect_to '/errors/not_found'
    end
  end

  def update

    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca_nombre = params[:marca]["marca_nombre"];

      @marca = Marca.find(params[:id]);
      @marca.marca_nombre = @marca_nombre;

      if @marca.save()
        redirect_to marcas_path, :notice => "La marca ha sido modificada";
      else
        render "edit";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def destroy

    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca = Marca.find(params[:id]);
      if @marca.destroy()
        redirect_to marcas_path, :notice => "La marca ha sido borrada";
      else
        redirect_to marcas_path, :notice => "La marca NO ha podido ser borrada";
      end
    else
      redirect_to '/errors/not_found'
    end

  end

  def elimMarca

    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca = Marca.find(params[:id]);
    else
      redirect_to '/errors/not_found'
    end

  end
end