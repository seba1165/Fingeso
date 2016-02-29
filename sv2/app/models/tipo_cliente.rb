class TipoCliente < ActiveRecord::Base

  attr_accessible :tipo_cliente_descr

  validates :tipo_cliente_descr, :presence => true, :uniqueness => true
end
