class DetCotOdcArt < ActiveRecord::Base
  belongs_to :cot_odc_art , foreign_key: "doc_cod"
  belongs_to :articulo, foreign_key: "art_cod"
end
