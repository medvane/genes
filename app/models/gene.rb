class Gene < ActiveRecord::Base
  belongs_to :taxonomy
  has_many :published_genes
end
