class RegistrationsController < Devise::RegistrationsController
 def new
   @cargos = CargoEmpleado.all
   super
 end
  def create
    super
  end
  def update
    super
  end
end
