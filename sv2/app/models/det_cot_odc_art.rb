class DetCotOdcArt < ActiveRecord::Base
  belongs_to :cot_odc_art , foreign_key: "doc_cod"
end
