class CotsOdcArtController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cots = CotOdcArt.all()
    else
      redirect_to '/errors/not_found'
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @arts = Articulo.all
    else
      redirect_to '/errors/not_found'
    end
  end

  def show
    @cot = CotOdcArt.find(params[:id]);
  end

  def create
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cart = carrito_actual_arts
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
          articulo = Articulo.find(id)
          totalArt = articulo.art_precio * quantity
        else
          totalArt = 0
        end
        total += totalArt
      end

      if DocPrevio.last.nil?
        @doc = 1
      else
        @doc = DocPrevio.all.last.doc_cod+1
      end


      @cot = CotOdcArt.new({ :doc_cod => @doc,
                            :emp_rut => current_empleado.emp_rut,
                            :doc_fecha => Time.now,
                            :cliente_cod => @cliente_cod,
                            :doc_total => total
                          });

      if @cliente_correo == "" || @tipo_cliente_cod == ""
        redirect_to new_cot_odc_art_path, :notice => "El correo del cliente y el tipo son obligatorios";
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
            articulo = Articulo.find(id)
            @det =DetCotOdcArt.new({ :doc_cod => @doc,
                                     :det_num_linea => num_linea,
                                     :art_cod => articulo.art_cod,
                                     :art_cant => quantity,
                                     :art_precio => articulo.art_precio
                                   });
            @det.save
            num_linea += 1
          end
          session[:cartart] = nil
          redirect_to show_path(@cot)
        else
          redirect_to cots_odc_art_index_path, :notice => "Error al guardar cotizacion ";
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
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @doc = DocPrevio.find(params[:id]);
      @not_vent = NotaDeVenta.where(doc_cod: @doc.doc_cod).first
      if @not_vent.nil?
        if @doc.destroy()
          redirect_to cots_odc_art_index_path, :notice => "La cotizacion ha sido eliminada";
        else
          redirect_to cots_odc_art_index_path, :notice => "La cotizacion no ha podido ser eliminada";
        end
      else
        redirect_to cots_odc_art_index_path, :notice => "La cotizacion no se puede borrar, tiene una nota de venta asociada";
      end
    end
  end

  def elimCotODCArt
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @doc = CotOdcArt.find(params[:id]);
    end
  end

  def aprobar
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cot = Cotizacion.find(params[:id]);
      @cotArt = CotOdcArt.find(params[:id]);
      @cot.cot_est_cod = 1
      if @cot.save
        @not_vent = NotaDeVenta.where(doc_cod: @cot.doc_cod).first
        @cot.not_ven_cod = @not_vent.not_ven_cod
        @cotArt.not_ven_cod = @not_vent.not_ven_cod
        @cotArt.save
        @cot.save
        redirect_to cots_odc_art_index_path, :notice => "Cotizacion Aprobada";
      else
        redirect_to cots_odc_art_index_path, :notice => "La cotizacion no pudo ser aprobada";
      end
    else
      redirect_to '/errors/not_found'
    end
  end
end
