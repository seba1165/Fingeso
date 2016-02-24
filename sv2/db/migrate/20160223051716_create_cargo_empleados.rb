class CreateCargoEmpleados < ActiveRecord::Migration
  def change
    change_table :cargo_empleados do |t|
      t.integer cargo_cod
      t.string cargo_nom
    end
  end
end
