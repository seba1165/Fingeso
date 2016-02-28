class DocPrevio < ActiveRecord::Base
  belongs_to :cliente, foreign_key: "cliente_cod", :autosave => true
end
