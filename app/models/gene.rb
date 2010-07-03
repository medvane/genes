class Gene < ActiveRecord::Base
  belongs_to :taxonomy
  has_many :published_genes
  has_many :reviewed_genes, :order => "reviewed_genes.articles_count desc", :include => :review
  has_one :homologene
  has_many :homologs, :through => :homologene
  has_many :gene_subjects, :order => "gene_subjects.id"
  has_many :gene_gos
  has_many :gos, :through => :gene_gos

  def to_s
    "#{symbol} (#{taxonomy.scientific_name})"
  end
end
