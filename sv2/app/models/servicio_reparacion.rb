class ServicioReparacion < ActiveRecord::Base
  validates :serv_nom, :presence => true, :uniqueness => true
end
