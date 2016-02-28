class Cliente < ActiveRecord::Base

  belongs_to :tipo_cliente , foreign_key: "tipo_cliente_cod"
  has_many :doc_previos

  validates :cliente_correo, :uniqueness => true
  validates :tipo_cliente_cod, :presence => true
end
