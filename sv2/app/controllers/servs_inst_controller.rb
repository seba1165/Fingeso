class ServsInstController < ApplicationController
  def index
    @cots = ServInst.all
  end

  def new
    @insts = SiVehiculoArticulo.all
    @cot = ServInst.new
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cart = carrito_actual
      @cliente_cod = params[:cliente][:cliente_cod];
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


      cliente = Cliente.new({   :cliente_cod => @cliente_cod,
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

      total = 0
      @cart.each do | id, quantity|
        if quantity != -1
          servicio = SiVehiculoArticulo.where(si_cod: id).first
          total_si = servicio.s_v_a_mo_pr + servicio.s_v_a_in_pr
          total_lin = total_si*quantity
        else
          total_lin = 0
        end
        total += total_lin
      end

      if DocPrevio.last.nil?
        @doc = 1
      else
        @doc = DocPrevio.all.last.doc_cod+1
      end


      @cot = ServInst.new({ :doc_cod => @doc,
                            :emp_rut => current_empleado.emp_rut,
                            :doc_fecha => Time.now,
                            :cliente_cod => @cliente_cod,
                            :doc_total => total
                           });

      if @cliente_correo == ""
        redirect_to new_serv_inst_path, :notice => "Ingrese correo del cliente";
      else
        if @cliente_cod == ""
          @cot.cliente = cliente
        else
          @cot.cliente_cod = @cliente_cod ##si el cliente ya existe, se actualiza al nuevo valor recibido
          @cot.cliente.cliente_nom = @cliente_nom
          @cot.cliente.cliente_ape = @cliente_ape
          @cot.cliente.tipo_cliente_cod = @tipo_cliente_cod
          @cot.cliente.cliente_direccion = @cliente_direccion
          @cot.cliente.cliente_comuna = @cliente_comuna
          @cot.cliente.cliente_tel = @cliente_tel
          @cot.cliente.cliente_emp = @cliente_emp
          @cot.cliente.cliente_frecuente = @cliente_frecuente
          @cot.cliente.cliente_rut = @cliente_rut
        end

        if @cot.save
          num_linea = 1
          @cart.each do | id, quantity|
            servicio = SiVehiculoArticulo.where(si_cod: id).first
            @det = ServInstDet.new({ :doc_cod => @doc,
                                    :si_num_linea => num_linea,
                                    :marca_cod => servicio.marca_cod,
                                    :modelo_cod => servicio.modelo_cod,
                                    :modelo_ano => servicio.modelo_ano,
                                    :art_cod => servicio.art_cod,
                                  });
            @det.save
            num_linea += 1
          end
          session[:cart] = nil
          redirect_to servs_inst_index_path, :notice => "Cotizacion Creada";
        else
          redirect_to serv_inst_index_path, :notice => "Error al guardar cotizacion ";
        end
      end
    else
      redirect_to '/errors/not_found'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
