class CotOdcArt < ActiveRecord::Base
  has_many :det_cot_odc_arts
  belongs_to :cliente, foreign_key: "cliente_cod", :autosave => true


end
