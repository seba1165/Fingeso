class CartartController < ApplicationController
  def index
    @cart = carrito_actual_arts
    @cot = CotOdcArt.new
    @cot.cliente = Cliente.new
  end

  def add
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
  end

  def rest
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
  end

  def clearCartArt
    session[:cartart] = nil
    redirect_to :action => :index
  end

end
