class CartArtController < ApplicationController
  def index
    @cart = carrito_actual_arts
    @cot = CotOdcArt.new
    @cot.cliente = Cliente.new
  end

  def add
    id = params[:id]
    if session[:cart_art] then
      cart_art = session[:cart_art]
    else
      session[:cart_art] = {}
      cart_art = session[:cart_art]
    end

    if cart_art[id] then
      cart_art[id] = cart_art[id] + 1
    else
      cart_art[id] = 1
    end

    redirect_to :action => :index
  end

  def clearCartArt
    session[:cart_art] = nil
    redirect_to :action => :index
  end

end
