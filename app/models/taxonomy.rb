class Taxonomy < ActiveRecord::Base
  has_many :genes
  has_many :reviewed_genes
  has_many :chromosomes
end
