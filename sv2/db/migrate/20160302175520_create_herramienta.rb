class CreateHerramienta < ActiveRecord::Migration
  def change
    change_table :herramienta do |t|

      t.timestamps null: false
    end
  end
end
