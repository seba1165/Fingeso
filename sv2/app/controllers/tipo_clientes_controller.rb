class TipoClientesController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @tipoCliente = TipoCliente.all();
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @tipoCliente = TipoCliente.new();
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @tipoCliente_descr = params[:tipo_cliente][:tipo_cliente_descr];

      #Creamos el objeto con los valores a ingresar.
      @tipoCliente = TipoCliente.new({
                                 :tipo_cliente_descr => @tipoCliente_descr,
                             });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @tipoCliente.save()
        redirect_to tipo_clientes_path, :notice => "El tipo cliente ha sido guardado con éxito";
      else
        render "new";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @tipoCliente = TipoCliente.find(params[:id]);
      @tipoCliente_descr = @tipoCliente.tipo_cliente_descr;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @tipo_cliente_descr = params[:tipo_cliente]["tipo_cliente_descr"];

      @tipoCliente = TipoCliente.find(params[:id]);
      @tipoCliente.tipo_cliente_descr = @tipo_cliente_descr;

      if @tipoCliente.save()
        redirect_to tipo_clientes_path, :notice => "El cliente ha sido modificado";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @tipoCliente = TipoCliente.find(params[:id]);
      if @tipoCliente.destroy()
        redirect_to tipo_clientes_path, :notice => "El tipo de cliente ha sido eliminado";
      else
        redirect_to tipo_clientes_path, :notice => "El tipo de cliente NO ha podido ser eliminado";
      end
    end
  end

  def elimTipoCliente
    @tipoCliente = TipoCliente.find(params[:id]);
  end
end
