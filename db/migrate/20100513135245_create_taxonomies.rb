class CreateTaxonomies < ActiveRecord::Migration
  def self.up
    create_table :taxonomies do |t|
      t.string :scientific_name
    end
    add_index :taxonomies, :scientific_name
  end

  def self.down
    drop_table :taxonomies
  end
end
