class AdminController < ApplicationController
  include Devise::Controllers::Helpers

  def registro
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @logs = Log.all
    end
  end

  def elimUsr
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @empleado = Empleado.find(params[:id]);
    end
  end
end
