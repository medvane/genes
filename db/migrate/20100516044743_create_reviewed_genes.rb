class CreateReviewedGenes < ActiveRecord::Migration
  def self.up
    create_table :reviewed_genes do |t|
      t.integer :review_id
      t.integer :gene_id
      t.integer :taxonomy_id
      t.string  :chromosome
      t.integer :articles_count, :default => 0
      t.decimal :specificity, :precision => 5, :scale => 2
      t.text :article_id_list
    end
    add_index :reviewed_genes, [:review_id, :articles_count]
    add_index :reviewed_genes, [:gene_id, :articles_count]
    add_index :reviewed_genes, [:review_id, :gene_id, :articles_count]
    add_index :reviewed_genes, [:review_id, :specificity, :articles_count], :name => "index_reviewed_genes_on_review_specificity_articles_count"
    add_index :reviewed_genes, [:review_id, :taxonomy_id, :chromosome, :articles_count], :name => "index_reviewed_genes_on_review_taxonomy_chromosome"
  end

  def self.down
    drop_table :reviewed_genes
  end
end
