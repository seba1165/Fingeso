class Empleado < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :cargo_empleado , foreign_key: "cargo_cod"

  attr_accessible  :emp_rut, :cargo_cod, :emp_nom, :emp_ape, :emp_tel,:email, :password, :password_confirmation, :cargo_empleado

  def administrador?
    self.cargo_empleado.cargo_nom.downcase == "administrador"
  end

  def vendedor?
    self.cargo_empleado.cargo_nom.downcase == "vendedor"
  end

  def jefeDeVentas?
    self.cargo_empleado.cargo_nom.downcase == "jefe de ventas"
  end

  def jefeDeServicios?
    self.cargo_empleado.cargo_nom.downcase == "jefe de servicios"
  end

  def jefeDeBodega?
    self.cargo_empleado.cargo_nom.downcase == "jefe de bodega"
  end

  validates :cargo_cod, :presence => true
  validates :emp_rut, rut: true

end
