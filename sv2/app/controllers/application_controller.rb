class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_empleado!

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:emp_nom, :emp_ape, :emp_rut, :emp_tel, :email, :cargo_cod, :password, :password_confirmation) }
  end

  def carrito_actual
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end

  def carrito_actual_arts
    if session[:cart_art] then
      @cart = session[:cart_art]
    else
      @cart_art = {}
    end
  end

end
