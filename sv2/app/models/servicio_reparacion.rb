class ServicioReparacion < ActiveRecord::Base

  attr_accessible :serv_nom
  validates :serv_nom, :presence => true, :uniqueness => true
end
