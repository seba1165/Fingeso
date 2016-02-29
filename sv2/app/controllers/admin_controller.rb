class AdminController < ApplicationController
  include Devise::Controllers::Helpers
  #Controlador para agregar usuarios

  def articulo

  end
  def servicio

  end

  def servEdInstal

  end
  def servEdRep
    #Editar reparacion
  end

  def editUsr
  end

  def inicio
  end

  def cotizacion
  end

  def nuevCot
    @cliente = Cliente.new
  end

  def nCotAgregArt
  end
  def nCotAgregSer
    
  end
  def cotNuevAgreg
    
  end

  def anularCot
  end

  def aprobCot
  end

  def abrirCot
  end

  def ordComp
  end

  def nuevaOC
  end

  def anularOC
  end

  def aprobOC
  end

  def abrirOC
  end

  def OT
  end

  def anularOT
  end

  def editarOT
  end

  def finOT
  end

  def notVent
  end

  def genNV
  end

  def pagoNV
  end
  
  def cotAgHerr
  end

  def cotAgRepto
  end

  def cotAgAcc
  end

  def cotAgRepar
  end

  def cotAgIns
  end
  def cotAgInstal
    
  end

  def parametro
  end

  def registro
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @logs = Log.all
    end
  end  

  def cotPrev
  end

  def cotFinal
  end

  def elimUsr
    @empleado = Empleado.find(params[:id]);
  end
end
