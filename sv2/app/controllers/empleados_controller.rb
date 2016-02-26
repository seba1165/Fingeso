class EmpleadosController < ApplicationController
  def index
    @cargos = CargoEmpleado.all
    @empleados = Empleado.all();
  end

  def new
    @empleado = Empleado.new();
  end

  def create
    #Recuperamos las varibles POST que vinieron desde la acción new.
    @emp_nom = params[:empleado][:emp_nom];
    @emp_ape = params[:empleado][:emp_ape];
    @emp_rut = params[:empleado][:emp_rut];
    @emp_tel = params[:empleado][:emp_tel];
    @email = params[:empleado][:email];
    @cargo_cod = params[:empleado][:cargo_cod];
    @password = params[:empleado][:password];
    @password_confirmation = params[:empleado][:password_confirmation];

    #Creamos el objeto con los valores a ingresar.
    @empleado = Empleado.new({
                           :emp_nom => @emp_nom,
                           :emp_ape => @emp_ape,
                           :emp_rut => @emp_rut,
                           :emp_tel => @emp_tel,
                           :email => @email,
                           :cargo_cod => @cargo_cod,
                           :password => @password,
                           :password_confirmation => @password_confirmation,

                       });
    #Verificamos si la tarea ha podido ser guardado correctamente.
    if @empleado.save()
      redirect_to empleados_path, :notice => "El empleado ha sido guardado con exito";
    else
      render "new";
    end
  end

  def edit
    @empleado = Empleado.find(params[:id]);
    @emp_nom = @empleado.emp_nom;
    @emp_ape = @empleado.emp_ape;
    @emp_tel = @empleado.emp_tel;
    @emp_rut = @empleado.emp_rut;
    @email = @empleado.email;
    @cargo_cod = @empleado.cargo_cod;
    @password = @empleado.password;
    @password_confirmation = @empleado.password_confirmation;
  end

  def update
    @emp_nom = params[:empleado]["emp_nom"];
    @emp_ape = params[:empleado]["emp_ape"];
    @emp_tel = params[:empleado]["emp_tel"];
    @emp_rut = params[:empleado]["emp_rut"];
    @email = params[:empleado]["email"];
    @cargo_cod = params[:empleado]["cargo_cod"];

    @empleado = Empleado.find(params[:id]);
    @empleado.emp_nom = @emp_nom;
    @empleado.emp_ape = @emp_ape;
    @empleado.emp_tel = @emp_tel;
    @empleado.emp_rut = @emp_rut;
    @empleado.email = @email;
    @empleado.cargo_cod = @cargo_cod;

    if @empleado.save()
      redirect_to empleados_path, :notice => "El empleado ha sido modificado";
    else
      render "edit";
    end
  end

  def destroy
    @empleado = Empleado.find(params[:id]);
    if @empleado.destroy()
      redirect_to empleados_path, :notice => "El empleado ha sido eliminado";
    else
      redirect_to empleados_path, :notice => "El empleado NO ha podido ser eliminado";
    end
  end
end
