class TipoArticulo < ActiveRecord::Base
  attr_accessible :tipo_nom
  validates :tipo_nom, :presence => true, :uniqueness => true
end
