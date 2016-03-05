class Cliente < ActiveRecord::Base

  belongs_to :tipo_cliente , foreign_key: "tipo_cliente_cod"
  has_many :doc_previos, :foreign_key => :doc_cod
  has_many :serv_insts, :foreign_key => :doc_cod

  validates :cliente_correo, :uniqueness => true
  validates_format_of :cliente_correo, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :tipo_cliente_cod, :presence => true

end
