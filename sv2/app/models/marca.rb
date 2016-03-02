class Marca < ActiveRecord::Base
  has_many :modelos, :foreign_key => :modelo_cod
end
