class SiVehiculoArticulo < ActiveRecord::Base
  self.primary_keys = :art_cod, :marca_cod, :modelo_cod, :modelo_ano
  belongs_to :articulo, foreign_key: "art_cod"
  belongs_to :modelo, foreign_key: "modelo_cod"
end
