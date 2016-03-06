class NotaDeVenta < ActiveRecord::Base
  belongs_to :estado_nota_de_venta, foreign_key: "not_ven_est_cod"
  belongs_to :metodo_de_pago, foreign_key: "pago_cod"
  belongs_to :documento_de_pago, foreign_key: "doc_pago"
end
