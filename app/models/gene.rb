class Gene < ActiveRecord::Base
  belongs_to :taxonomy
  has_many :published_genes
  has_many :reviewed_genes, :order => "reviewed_genes.articles_count desc", :include => :review
  has_one :homologene
  has_many :homologs, :through => :homologene
  has_many :gene_subjects

  def to_s
    "#{symbol} (#{taxonomy.scientific_name})"
  end
end
