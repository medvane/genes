class Review < ActiveRecord::Base
  has_many :reviewed_genes, :dependent => :delete_all
  has_many :reviewed_gos, :dependent => :delete_all, :order => "articles_count desc", :include => :go
  
  validates_presence_of :search_term, :title

  scope :built, where(:built => true).order("id desc")
  scope :popular, built.order("hits desc")
  scope :inprocess, where(:built => false)

  def hit!
    increment!(:hits)
  end
end
