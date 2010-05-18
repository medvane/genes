class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :search_term
      t.string :title
      t.integer :search_results_count, :default => 0
      t.integer :genes_count, :default => 0
      t.integer :articles_count, :default => 0
      t.integer :hits, :default => 0
      t.boolean :built, :default => false
      t.datetime :built_at
      t.timestamps
    end
    add_index :reviews, [:built, :hits]
  end

  def self.down
    drop_table :reviews
  end
end
