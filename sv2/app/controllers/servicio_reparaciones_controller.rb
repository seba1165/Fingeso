class ServicioReparacionesController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      @serv_repar = ServicioReparacion.all();
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      @serv_repar = ServicioReparacion.new();
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @serv_nom = params[:servicio_reparacion][:serv_nom];

      #Creamos el objeto con los valores a ingresar.
      @serv_repar = ServicioReparacion.new({
                                               :serv_nom => @serv_nom,
                                           });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @serv_repar.save()
        redirect_to servicio_reparaciones_path, :notice => "El servicio de reparación ha sido guardado con éxito";
      else
        render "new";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      @serv_repar = ServicioReparacion.find(params[:id]);
      @sr_nom = @serv_repar.serv_nom;
    else
      redirect_to '/errors/not_found'
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      @sr_nom = params[:servicio_reparacion]["serv_nom"];

      @serv_repar = ServicioReparacion.find(params[:id]);
      @serv_repar.serv_nom = @sr_nom;

      if @serv_repar.save()
        redirect_to servicio_reparaciones_path, :notice => "El servicio de reparación ha sido modificado";
      else
        render "edit";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
      @serv_repar = ServicioReparacion.find(params[:id]);
      if @serv_repar.destroy()
        redirect_to servicio_reparaciones_path, :notice => "El servicio de reparación ha sido eliminado";
      else
        redirect_to servicio_reparaciones_path, :notice => "El servicio de reparación NO ha podido ser eliminado";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def elimSR
      if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
        @serv_repar = ServicioReparacion.find(params[:id]);
      else
        redirect_to '/errors/not_found'
      end
  end
end
