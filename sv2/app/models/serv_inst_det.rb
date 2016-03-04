class ServInstDet < ActiveRecord::Base
  belongs_to :serv_inst , foreign_key: "doc_cod"
end
