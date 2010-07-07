class Go < ActiveRecord::Base
  has_many :gene_gos
  has_many :reviewed_gos

  def goid
    sprintf("GO:%07d", id)
  end

  def golink
    "http://amigo.geneontology.org/cgi-bin/amigo/term-details.cgi?term=#{goid}"
  end
end
