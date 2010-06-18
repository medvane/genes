class CreateGenes < ActiveRecord::Migration
  def self.up
    create_table :genes do |t|
      t.integer :taxonomy_id
      t.string :symbol
      t.string :name
      t.string :chromosome
      t.string :map_location
      t.integer :articles_count, :default => 0
      t.integer :start_position
      t.integer :end_position
    end
    add_index :genes, :symbol
    add_index :genes, :articles_count
    add_index :genes, [:taxonomy_id, :articles_count]
  end

  def self.down
    drop_table :genes
  end
end
