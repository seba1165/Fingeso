class CotOdcArt < ActiveRecord::Base
  has_many :det_cot_odc_arts, :foreign_key => :doc_cod

  def subtotal
    det_cot_odc_arts.collect { |oi| oi.valid? ? (oi.art_cant * oi.art_precio_unidad) : 0 }.sum
  end
  private

  def actualizar_subtotal
    self[:doc_neto] = subtotal
  end

  def neto
    det_cot_odc_arts.collect { |oi| oi.valid? ? (oi.art_cant * oi.art_precio_unitario) : 0 }.sum
  end
end
