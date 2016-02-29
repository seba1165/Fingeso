class CotOdcArtsController < ApplicationController
  def index
    @cotodcArts = CotOdcArt.all()
  end

  def new
    @cotodcArt = CotOdcArt.new
  end

  def create
    @doc = DocPrevio.new(doc_params)
    cliente = Cliente.new(cliente_params)
    @doc.doc_fecha = Time.new #ponemos la fecha del sistema
    #al recibir los datos, comprobar si existe el cliente, entonces se pueden actualizar sus datos

    # si no existe el cliente, registrar uno nuevo
    if @sale.client_id.nil?
      @sale.client = cliente
    else
      @sale.client.nombre = client.nombre ##si el cliente ya existe, se actualiza al nuevo valor recibido
      @sale.client.direccion = client.direccion
      @sale.client.telefono = client.telefono
      @sale.client.email = client.email
    end

    #puts "Datos recibidos de la nueva venta"
    #puts "Cliente>> " + @sale.client_id.to_s + @sale.client.nombre
    #puts "Productos recibidos: "

    # mostrar en consola los productos incluidos
    # @sale.saleDetails.each do |item|
    # # #params[:saledetails].each do |item|
    #    puts "id: " + item.product_id.to_s + ", p. u: " + item.preciounitario.to_s + ", cantidad: " + item.cantidad.to_s + ", importe: " + item.importe.to_s
    # end



    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def elimCotODCArt
    @cotodcArt = CotOdcArt.find(params[:id]);
  end
end
