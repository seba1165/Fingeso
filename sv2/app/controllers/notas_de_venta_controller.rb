class NotasDeVentaController < ApplicationController
  def index
    @notas = NotaDeVenta.all
  end

  def new
  end

  def edit
    @not_ven = NotaDeVenta.find(params[:id]);

  end

  def update
    @pago_cod = params[:not_ven]["pago_cod"];
    @doc_pago = params[:not_ven]["doc_pago"]
    @not_ven = NotaDeVenta.find(params[:id]);
    @not_ven.pago_cod = @pago_cod
    @cotArt = CotOdcArt.where(doc_cod: @not_ven.doc_cod).first
    @not_ven.not_ven_est_cod = 1

    if @cotArt != nil
      @dets = DetCotOdcArt.where(doc_cod: @cotArt.doc_cod)
      @dets.each do |d|
        @art = Articulo.where(art_cod: d.art_cod).first
        @stock = @art.art_stock - d.art_cant
        if @stock < 0
          redirect_to notas_de_venta_index_path, :notice => "La nota de venta no puede ser pagada. Problema de Stock";
        end
      end
    end

    if @not_ven.save
      if @cotArt != nil
        @dets = DetCotOdcArt.where(doc_cod: @cotArt.doc_cod)
        @dets.each do |d|
          @art = Articulo.where(art_cod: d.art_cod).first
          @art.art_stock = @art.art_stock - d.art_cant
          @art.save
          @herr = Herramienta.where(art_cod: d.art_cod).first
          if @herr != nil
            @herr.art_stock = @herr.art_stock - d.art_cant
            @herr.save
          else
            @acc = Accesorio.where(art_cod: d.art_cod).first
            if @acc != nil
              @acc.art_stock = @acc.art_stock - d.art_cant
              @acc.save
            else
              @ins = Insumo.where(art_cod: d.art_cod).first
              if @ins != nil
                @ins.art_stock = @ins.art_stock - d.art_cant
                @ins.save
              else
                @rep = Repuesto.where(art_cod: d.art_cod).first
                if @rep != nil
                  @rep.art_stock = @rep.art_stock - d.art_cant
                  @rep.save
                end
              end
            end
          end

        end
      end
      @doc = DocumentoDePago.new({:doc_pago_fecha => Time.now})
      if @doc_pago == "1"
        if @doc.save
          @boleta = Boleta.new({:doc_pago_cod => @doc.doc_pago_cod,
                                :doc_pago_fecha => @doc.doc_pago_fecha})
          @boleta.save
          @not_ven.doc_pago_cod = @boleta.doc_pago_cod
          @not_ven.save
          redirect_to notas_de_venta_index_path, :notice => "Nota de Venta Pagada, con boleta";
        end
      else
        if @doc.save
        @factura = Factura.new({:doc_pago_cod => @doc.doc_pago_cod,
                                :doc_pago_fecha => @doc.doc_pago_fecha,
                                :fact_est_cod => 0
                               })
        @factura.save
        @not_ven.doc_pago_cod = @factura.doc_pago_cod
        @not_ven.save
        redirect_to notas_de_venta_index_path, :notice => "Nota de Venta Pagada, con factura";
      end
      end
    else
      redirect_to notas_de_venta_index_path, :notice => "La nota no pudo ser pagada";
    end


  end

  def create
  end

  def destroy
  end

end
