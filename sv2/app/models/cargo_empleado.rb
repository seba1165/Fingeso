class CargoEmpleado < ActiveRecord::Base
  has_one :empleado
  #validates :cargo_nom, :presence => true, :uniqueness => true
end