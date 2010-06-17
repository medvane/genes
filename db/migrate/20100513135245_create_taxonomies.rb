class CreateTaxonomies < ActiveRecord::Migration
  def self.up
    create_table :taxonomies do |t|
      t.string :scientific_name
      t.integer :genes_count, :default => 0
    end
  end

  def self.down
    drop_table :taxonomies
  end
end
