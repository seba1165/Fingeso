class Empleado < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :cargo_empleado

  attr_accessible  :emp_rut, :cargo_cod, :emp_nom, :emp_ape, :emp_tel,:email, :password, :password_confirmation

  def administrador?
    self.cargo_cod == 0
  end

  def vendedor?
    self.cargo_cod == 1
  end

  validates :cargo_cod, :presence => true
  validates :emp_rut, rut: true

end
