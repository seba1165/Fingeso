class ClientesController < ApplicationController
  include Devise::Controllers::Helpers

  autocomplete :cliente, :cliente_correo, :display_value => :cliente_correo, :extra_data => [:cliente_direccion, :cliente_tel, :cliente_nom, :cliente_ape, :cliente_comuna, :tipo_cliente_cod, :cliente_emp, :cliente_frecuente, :cliente_rut, :cliente_cod] do |items|
    respond_to do |format|
      format.json { render :json => @items }
    end
  end

  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @clientes = Cliente.all();
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cliente = Cliente.new();
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      #Recuperamos las varibles POST que vinieron desde la acción new.
      @tipo_cliente_cod = params[:cliente][:tipo_cliente_cod];
      @cliente_nom = params[:cliente][:cliente_nom];
      @cliente_ape = params[:cliente][:cliente_ape];
      @cliente_direccion = params[:cliente][:cliente_direccion];
      @cliente_comuna = params[:cliente][:cliente_comuna];
      @cliente_tel = params[:cliente][:cliente_tel];
      @cliente_correo = params[:cliente][:cliente_correo];
      @cliente_emp = params[:cliente][:cliente_emp];
      @cliente_frecuente = params[:cliente][:cliente_frecuente];
      @cliente_rut = params[:cliente][:cliente_rut];

      #Creamos el objeto con los valores a ingresar.
      @cliente = Cliente.new({
                                 :tipo_cliente_cod => @tipo_cliente_cod,
                                 :cliente_nom => @cliente_nom,
                                 :cliente_ape => @cliente_ape,
                                 :cliente_direccion => @cliente_direccion,
                                 :cliente_comuna => @cliente_direccion,
                                 :cliente_tel => @cliente_tel,
                                 :cliente_correo => @cliente_correo,
                                 :cliente_emp => @cliente_emp,
                                 :cliente_frecuente => @cliente_frecuente,
                                 :cliente_rut => @cliente_rut,

                             });
      #Verificamos si la tarea ha podido ser guardado correctamente.
      if @cliente.save()
        redirect_to clientes_path, :notice => "El cliente ha sido guardado con éxito";
      else
        render "new"
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cliente = Cliente.find(params[:id]);
      @tipo_cliente_cod = @cliente.tipo_cliente_cod;
      @cliente_nom = @cliente.cliente_nom;
      @cliente_ape = @cliente.cliente_ape;
      @cliente_direccion = @cliente.cliente_direccion;
      @cliente_comuna = @cliente.cliente_comuna;
      @cliente_tel = @cliente.cliente_tel;
      @cliente_correo = @cliente.cliente_correo;
      @cliente_emp = @cliente.cliente_emp;
      @cliente_frecuente = @cliente.cliente_frecuente;
      @cliente_rut = @cliente.cliente_rut;
    else
      redirect_to '/errors/not_found'
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @tipo_cliente_cod = params[:cliente]["tipo_cliente_cod"];
      @cliente_nom = params[:cliente]["cliente_nom"];
      @cliente_ape = params[:cliente]["cliente_ape"];
      @cliente_direccion = params[:cliente]["cliente_direccion"];
      @cliente_comuna = params[:cliente]["cliente_comuna"];
      @cliente_tel = params[:cliente]["cliente_tel"];
      @cliente_correo = params[:cliente]["cliente_correo"];
      @cliente_emp = params[:cliente]["cliente_emp"];
      @cliente_frecuente = params[:cliente]["cliente_frecuente"];
      @cliente_rut = params[:cliente]["cliente_rut"];

      @cliente = Cliente.find(params[:id]);
      @cliente.tipo_cliente_cod = @tipo_cliente_cod;
      @cliente.cliente_nom = @cliente_nom;
      @cliente.cliente_ape = @cliente_ape;
      @cliente.cliente_direccion = @cliente_direccion;
      @cliente.cliente_comuna = @cliente_comuna;
      @cliente.cliente_tel = @cliente_tel;
      @cliente.cliente_correo = @cliente_correo;
      @cliente.cliente_emp = @cliente_emp;
      @cliente.cliente_frecuente = @cliente_frecuente;
      @cliente.cliente_rut = @cliente_rut;


      if @cliente.save()

        redirect_to clientes_path, :notice => "El cliente ha sido modificado";
      else
        render "edit";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cliente = Cliente.find(params[:id]);
      @doc = DocPrevio.find_by(cliente_cod: @cliente.cliente_cod)
      if @doc.nil?
        if @cliente.destroy()
          redirect_to clientes_path, :notice => "El cliente ha sido eliminado";
        else
          redirect_to clientes_path, :notice => "El cliente NO ha podido ser eliminado";
        end
      else
        redirect_to clientes_path, :notice => "El cliente NO ha podido ser eliminado ya que tiene documentos asociados";
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def elimCliente
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @cliente = Cliente.find(params[:id]);
    end
  end
end
