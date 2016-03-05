class ServInst < ActiveRecord::Base
  belongs_to :cliente, foreign_key: "cliente_cod", :autosave => true
  has_many :serv_inst_dets
end
