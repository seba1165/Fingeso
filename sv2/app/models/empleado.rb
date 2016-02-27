class Empleado < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :cargo_empleado , foreign_key: "cargo_cod"

  attr_accessible  :emp_rut, :cargo_cod, :emp_nom, :emp_ape, :emp_tel,:email, :password, :password_confirmation, :cargo_empleado

  def administrador?
    self.cargo_cod == 10
  end

  def vendedor?
    self.cargo_cod == 1
  end

  validates :cargo_cod, :presence => true
  validates :emp_rut, rut: true

end
