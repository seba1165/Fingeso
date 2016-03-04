class Cotizacion < ActiveRecord::Base
  belongs_to :estado_cotizacion, foreign_key: "cot_est_cod"
  before_create :setear_estado_cotizacion

  # validates :doc_cod, :presence => true, :uniqueness => true
  # validates :cot_est_cod, :presence => true
  # validates :cliente_cod, :presence => true
  # validates :not_ven_cod, :presence => true
  # validates :emp_rut, :presence => true
  # validates :doc_fecha, :presence => true
  # validates :doc_obs
  # validates :doc_neto, :presence => true
  # validates :doc_iva, :presence => true
  # validates :doc_total, :presence => true
  # validates :doc_total_desc, :presence => true
  

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
