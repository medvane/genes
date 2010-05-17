class Gene < ActiveRecord::Base
  belongs_to :taxonomy
  has_many :published_genes
  has_many :reviewed_genes, :order => "reviewed_genes.articles_count desc", :include => :review
  has_one :homologene

  def to_s
    "#{symbol} (#{taxonomy.scientific_name})"
  end

  def homologs
    if homologene.present?
      hg = Homologene.where(:homolog_id => homologene.homolog_id).where(["homologenes.gene_id != ?", id]).includes(:gene => :taxonomy).map {|h| h.gene}.compact
    else
      []
    end
  end
end
