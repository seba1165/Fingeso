class DetCotOdcArtsController < ApplicationController
  def create
    @cot_odc_art = cot_art_odc_actual
    @detalle = @cot_odc_art.det_cot_odc_arts.new(parametros_detalle)
    @cot_odc_art.save
    session[:id] = @cot_odc_art.id
  end

  def update
    @cot_odc_art = cot_odc_art_actual
    @detalle = @cot.det_cot_odc_arts.find(params[:id])
    @detalle.update_attributes(parametros_detalle)
    @detalles = @cot.det_cot_odc_arts
  end

  def destroy
    @cot = cot_odc_art_actual
    @detalle = @cot.det_cot_odc_arts.find(params[:id])
    @detalle.destroy
    @detalles = @cot.det_cot_odc_arts
  end

  private
  def parametros_detalle
    params.require(:detalle).permit(:art_cant, :art_cod)
  end
end
