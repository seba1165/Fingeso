class CartController < ApplicationController
  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      @cart = carrito_actual
      @cot = ServInst.new
      @cot.cliente = Cliente.new
    else
      redirect_to '/errors/not_found'
    end
  end

  def add

    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      id = params[:id]
      if session[:cart] then
        cart = session[:cart]
      else
        session[:cart] = {}
        cart = session[:cart]
      end

      if cart[id] then
        cart[id] = cart[id] + 1
      else
        cart[id] = 1
      end

      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end

  def rest
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      id = params[:id]
      if session[:cart] then
        cart = session[:cart]
      else
        session[:cart] = {}
        cart = session[:cart]
      end
      if cart[id]< 2 then
        cart[id]= -1
      else
        cart[id] = cart[id]-1
      end

      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end

  def clearCart
    if current_empleado.cargo_empleado.cargo_nom.downcase == "administrador" || current_empleado.cargo_empleado.cargo_nom.downcase == "vendedor"
      session[:cart] = nil
      redirect_to :action => :index
    else
      redirect_to '/errors/not_found'
    end
  end
end
