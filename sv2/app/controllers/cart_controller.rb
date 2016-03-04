class CartController < ApplicationController
  def index
    @cart = carrito_actual
    @cot = ServInst.new
    @cot.cliente = Cliente.new
  end

  def add
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
  end

  def rest
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
  end

  def clearCart
    session[:cart] = nil
    redirect_to :action => :index
  end
end
