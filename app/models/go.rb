class Go < ActiveRecord::Base
  has_many :gene_gos
  has_many :reviewed_gos
end
