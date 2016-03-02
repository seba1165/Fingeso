class Modelo < ActiveRecord::Base
  belongs_to :marca, foreign_key: "marca_cod", :autosave => true
end
