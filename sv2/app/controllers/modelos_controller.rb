class ModelosController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelos = Modelo.all
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.new();
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @modelo_nombre = params[:modelo][:modelo_nombre];
      @marca_cod = params[:modelo][:marca_cod];
      @modelo_ano = params[:modelo][:modelo_ano];

      #Creamos el objeto con los valores a ingresar.
      @modelo = Modelo.new({
                             :modelo_nombre => @modelo_nombre,
                             :marca_cod => @marca_cod,
                             :modelo_ano => @modelo_ano,
                           });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @modelo.save()
        redirect_to modelos_path, :notice => "El modelo ha sido guardado con éxito";
      else
        render "new";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.find(params[:id]);
      @modelo_nombre = @modelo.modelo_nombre;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo_nombre = params[:modelo]["modelo_nombre"];

      @modelo = Modelo.find(params[:id]);
      @modelo.modelo_nombre = @modelo_nombre;

      if @modelo.save()
        redirect_to modelos_path, :notice => "El modelo ha sido modificado";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.find(params[:id]);
      if @modelo.destroy()
        redirect_to modelos_path, :notice => "El modelo ha sido borrado";
      else
        redirect_to modelos_path, :notice => "El modelo NO ha podido ser borrado";
      end
    end
  end

  def elimModelo
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.find(params[:id]);
    end
  end
end
