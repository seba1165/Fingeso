class DocPreviosController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @docs = DocPrevio.all
      @cots = Cotizacion.all
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @doc = DocPrevio.new
      # asociar un nuevo cliente
      @doc.cliente = Cliente.new
    else
      redirect_to '/errors/not_found'
    end
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
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

      @doc = DocPrevio.new({ :emp_rut => current_empleado.emp_rut,
                             :doc_fecha => Time.now,
                             :cliente_cod => @cliente_cod
                           });

      if cliente.cliente_correo.nil?
        format.html { redirect_to doc_previos_new_path, notice: 'Ingrese correo del cliente' }
      else
        if cliente.cliente_cod.nil?
          @doc.cliente = cliente
        else
          @doc.cliente_cod = @cliente_cod ##si el cliente ya existe, se actualiza al nuevo valor recibido
          @doc.cliente.cliente_nom = @cliente_nom
          @doc.cliente.cliente_ape = @cliente_ape
          @doc.cliente.tipo_cliente_cod = @tipo_cliente_cod
          @doc.cliente.cliente_direccion = @cliente_direccion
          @doc.cliente.cliente_comuna = @cliente_comuna
          @doc.cliente.cliente_tel = @cliente_tel
          @doc.cliente.cliente_emp = @cliente_emp
          @doc.cliente.cliente_frecuente = @cliente_frecuente
          @doc.cliente.cliente_rut = @cliente_rut
        end

        respond_to do |format|
          if @doc.save
            @cot = Cotizacion.new({ :emp_rut => current_empleado.emp_rut,
                                    :doc_fecha => @doc.doc_fecha,
                                    :cliente_cod => @cliente_cod,
                                    :doc_cod => @doc.doc_cod
                                  });
            @cot.cot_est_cod = 0
            if @cot.save
              @cot_odc_art = CotOdcArt.new({ :emp_rut => current_empleado.emp_rut,
                                             :doc_fecha => @doc.doc_fecha,
                                             :cliente_cod => @cliente_cod,
                                             :doc_cod => @doc.doc_cod
                                           });

              @det_cot_odc_art = DetCotOdcArt.new

              if @cot_odc_art.save
                format.html { redirect_to doc_previos_path, notice: 'Cotizacion por artículos generada para el cliente.' }
                format.json { render :show, status: :created, location: @doc }
              else
                format.html { render :new }
                format.json { render json: @cot_odc_art.errors, status: :unprocessable_entity }
              end


            else
              format.html { render :new }
              format.json { render json: @cot.errors, status: :unprocessable_entity }
            end
          else
            format.html { render :new }
            format.json { render json: @doc.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      redirect_to '/errors/not_found'
    end

  end


  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @doc = DocPrevio.find(params[:id]);
      if @doc.destroy()
        redirect_to doc_previos_path, :notice => "La cotizacion ha sido eliminada";
      else
        redirect_to doc_previos_path, :notice => "La cotizacion no ha podido ser eliminada";
      end
    end
  end

  def elimDocPrevio
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      @doc = DocPrevio.find(params[:id]);
    else
      redirect_to '/errors/not_found'
    end
  end

end