class CartartController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cart = carrito_actual_arts
      @cot = CotOdcArt.new
      @cot.cliente = Cliente.new
    else
      redirect_to '/errors/not_found'
    end
  end

  def add
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      id = params[:id]
      if session[:cartart] then
        cartart = session[:cartart]
      else
        session[:cartart] = {}
        cartart = session[:cartart]
      end

      if cartart[id] then
        cartart[id] = cartart[id] + 1
      else
        cartart[id] = 1
      end

      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end

  def rest
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      id = params[:id]
      if session[:cartart] then
        cartart = session[:cartart]
      else
        session[:cartart] = {}
        cartart = session[:cartart]
      end
      if cartart[id]< 2 then
        cartart[id]= -1
      else
        cartart[id] = cartart[id]-1
      end

      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end

  def clearCartArt
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      session[:cartart] = nil
      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end
end
