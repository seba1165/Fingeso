class Modelo < ActiveRecord::Base
  belongs_to :marca, foreign_key: "marca_cod", :autosave => true
  has_many :si_vehiculo_articulos, :foreign_key => :modelo_cod
  self.primary_keys = :marca_cod, :modelo_cod, :modelo_ano
end
