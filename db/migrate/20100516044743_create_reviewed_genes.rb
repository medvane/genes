class CreateReviewedGenes < ActiveRecord::Migration
  def self.up
    create_table :reviewed_genes do |t|
      t.integer :review_id
      t.integer :gene_id
      t.integer :articles_count, :default => 0
      t.text :article_id_list
    end
    add_index :reviewed_genes, [:review_id, :articles_count]
    add_index :reviewed_genes, [:gene_id, :articles_count]
    add_index :reviewed_genes, [:review_id, :gene_id, :articles_count]
  end

  def self.down
    drop_table :reviewed_genes
  end
end
