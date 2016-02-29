class Cotizacion < ActiveRecord::Base
  belongs_to :estado_cotizacion, foreign_key: "cot_est_cod"
  before_create :setear_estado_cotizacion

  def neto
    @cot_art = CotOdcArt.find(self.doc_cod)
    @cot_art.det_cot_odc_arts.collect { |oi| oi.valid? ? (oi.art_cant * oi.art_precio_unidad) : 0 }.sum
  end
  private

  def setear_estado_cotizacion
    self.cot_est_cod = 0
  end

  def update_subtotal
    @cot_art = CotOdcArt.find(self.doc_cod)
    @cot_art[:doc_neto] = neto
  end
end
