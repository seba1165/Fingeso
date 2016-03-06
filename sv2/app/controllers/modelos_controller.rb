class ModelosController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @modelos = Modelo.all
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @modelo = Modelo.new();
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
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
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @modelo = Modelo.find(params[:id]);
      @marca_cod = @modelo.marca_cod
      @modelo_nombre = @modelo.modelo_nombre;
      @modelo_ano = @modelo_ano
    else
      redirect_to '/errors/not_found'
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @marca_cod = params[:modelo]["marca_cod"];
      @modelo_nombre = params[:modelo]["modelo_nombre"];
      @modelo_ano = params[:modelo]["modelo_ano"];

      @modelo = Modelo.find(params[:id]);
      @modelo.marca_cod = @marca_cod;
      @modelo.modelo_nombre = @modelo_nombre;
      @modelo.modelo_ano = @modelo_ano;

      if @modelo.save()
        redirect_to modelos_path, :notice => "El modelo ha sido modificado";
      else
        render "edit";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @modelo = Modelo.find(params[:id]);
      if @modelo.destroy()
        redirect_to modelos_path, :notice => "El modelo ha sido borrado";
      else
        redirect_to modelos_path, :notice => "El modelo NO ha podido ser borrado";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def elimModelo

    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @modelo = Modelo.find(params[:id]);
    else
      redirect_to '/errors/not_found'
    end
  end
end
