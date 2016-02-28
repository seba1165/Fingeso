class ReparacionServiciosController < ApplicationController
 include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @serv_repar = ReparacionServicio.all();
    end
  end

  def new
     if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @serv_repar = ReparacionServicio.new();
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @sr_nom = params[:servicio_reparacion][:serv_nom];

      #Creamos el objeto con los valores a ingresar.
      @serv_repar = ReparacionServicio.new({
                                 :serv_nom => @sr_nom,
                             });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @serv_repar.save()
        redirect_to reparacion_servicio_path, :notice => "El servicio de reparacións ha sido guardado con éxito";
      else
        render "new";
      end
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @serv_repar = ReparacionServicio.find(params[:id]);
      @sr_nom = @serv_repar.serv_nom;
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @sr_nom = params[:servicio_reparacion]["serv_nom"];

      @serv_repar = ReparacionServicio.find(params[:id]);
      @serv_repar.serv_nom = @sr_nom;

      if @serv_repar.save()
        redirect_to reparacion_servicio_path, :notice => "El servicio de reparación ha sido modificado";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @serv_repar = ReparacionServicio.find(params[:id]);
      if @serv_repar.destroy()
        redirect_to reparacion_servicio_path, :notice => "El servicio de reparación ha sido eliminado";
      else
        redirect_to reparacion_servicio_path, :notice => "El servicio de reparación NO ha podido ser eliminado";
      end
    end
  end

  def elimSR
    @serv_repar = ReparacionServicio.find(params[:id]);
  end
end