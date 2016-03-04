class DetCotOdcArt < ActiveRecord::Base
  belongs_to :articulo , foreign_key: "art_cod"
  belongs_to :cot_odc_art , foreign_key: 'doc_cod'

  validates :art_cant, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :articulo_presente
  validate :cot_presente
  # validate :doc_cod
  # validate :det_num_linea
  # validate :art_cod
  # validate :art_desc
  # validate :art_precio_unidad

  before_save :finalize

  def art_precio_unidad
    if persisted?
      self[:art_precio_unidad]
    else
      articulo.art_precio
    end
  end

  def precio_total
    precio_unidad * art_cant
  end

  private
  def articulo_presente
    if articulo.nil?
      errors.add(:articulo, "no es valido o no está activo.")
    end
  end

  def cot_presente
    if cot_odc_art.nil?
      errors.add(:cot_odc_art, "no es una cotización válida.")
    end
  end

  def finalizar
    self[:art_precio_unidad] = art_precio_unidad
    self[:precio_total] = art_cant * self[:art_precio_unidad]
  end
end
