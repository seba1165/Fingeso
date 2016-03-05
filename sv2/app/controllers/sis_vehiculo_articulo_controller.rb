class SisVehiculoArticuloController < ApplicationController
  include Devise::Controllers::Helpers

  def index
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @SIs = SiVehiculoArticulo.all
    end
  end

  def new
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @SI = SiVehiculoArticulo.new
      @marcas = Marca.all
      @arts = ParaInstalacion.all
    end
  end

 def create
  if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
    redirect_to '/errors/not_found'
  else
    @marcas = Marca.all
    #Recuperamos las varibles POST que vinieron desde la acción new.
    @art_cod = params[:sis_vehiculo_articulo][:art_cod];
    @modelo_cod = params[:sis_vehiculo_articulo][:modelo_cod];
    @s_v_a_mo_pr = params[:si_vehiculo_articulo][:s_v_a_mo_pr];
    @s_v_a_in_pr = params[:si_vehiculo_articulo][:s_v_a_in_pr];
    @marca_cod = Modelo.where(modelo_cod: @modelo_cod).first.marca_cod
    @modelo_ano = Modelo.where(modelo_cod: @modelo_cod).first.modelo_ano


    #Creamos el objeto con los valores a ingresar.
    @SI = SiVehiculoArticulo.new({
                             :art_cod => @art_cod,
                             :marca_cod => @marca_cod,
                             :modelo_cod => @modelo_cod,
                             :modelo_ano => @modelo_ano,
                             :s_v_a_mo_pr => @s_v_a_mo_pr,
                             :s_v_a_in_pr => @s_v_a_in_pr
                         });
    #Verificamos si la tarea ha podido ser guardado correctamente.
    if @SI.save()
      redirect_to sis_vehiculo_articulo_path, :notice => "El servicio ha sido guardado con éxito";
    else
      render "new";
    end
  end
 end

  def edit
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @SI = SiVehiculoArticulo.where(art_cod: params[:art_cod], modelo_cod: params[:modelo_cod], modelo_ano: params[:modelo_ano]).first
      @empleado = Empleado.find(params[:id]);
    end
  end

  def update
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @art_cod = params[:si_vehiculo_articulo]["art_cod"];
      @modelo_cod = params[:si_vehiculo_articulo]["modelo_cod"];
      @modelo_ano = params[:si_vehiculo_articulo]["modelo_ano"];
      @s_v_a_mo_pr = params[:si_vehiculo_articulo]["s_v_a_mo_pr"];
      @s_v_a_in_pr = params[:si_vehiculo_articulo]["s_v_a_in_pr"];

      @SI = SiVehiculoArticulo.find(params[:id]);
      @SI.art_cod = @art_cod;
      @SI.marca_cod = @marca_cod;
      @SI.modelo_cod = @modelo_cod;
      @SI.modelo_ano = @modelo_ano;
      @SI.s_v_a_mo_pr = @s_v_a_mo_pr;
      @SI.s_v_a_in_pr = @s_v_a_in_pr;


      if @SI.save()
        redirect_to si_vehiculo_articulos_path, :notice => "El S.I. ha sido modificado";
      else
        render "edit";
      end
    end
  end

  def destroy
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.find(params[:id]);
      if @modelo.destroy()
        redirect_to modelos_path, :notice => "El modelo ha sido borrado";
      else
        redirect_to modelos_path, :notice => "El modelo NO ha podido ser borrado";
      end
    end
  end

  def elimSI
    if current_empleado.cargo_empleado.cargo_nom.downcase != "administrador"
      redirect_to '/errors/not_found'
    else
      @modelo = Modelo.find(params[:id]);
    end
  end
end