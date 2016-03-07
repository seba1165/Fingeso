class Empleado < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :cargo_empleado , foreign_key: "cargo_cod"

  attr_accessible  :emp_rut, :cargo_cod, :emp_nom, :emp_ape, :emp_tel,:email, :password, :password_confirmation, :cargo_empleado

  def administrador?
    self.cargo_empleado.cargo_nom.downcase == "administrador"
  end

  def profesor?
    self.cargo_empleado.cargo_nom.downcase == "profesor"
  end

  def alumno?
    self.cargo_empleado.cargo_nom.downcase == "alumno"
  end


  validates :cargo_cod, :presence => true
  validates :emp_rut, :presence => true, rut: true
  validates :email, :uniqueness => true
  validates :emp_nom, :uniqueness => true
  validates :emp_ape, :uniqueness => true

end
