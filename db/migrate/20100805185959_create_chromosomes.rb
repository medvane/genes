class CreateChromosomes < ActiveRecord::Migration
  def self.up
    create_table :chromosomes do |t|
      t.integer :taxonomy_id
      t.string :name
      t.integer :length
    end
    add_index :chromosomes, [:taxonomy_id, :name]
  end

  def self.down
    drop_table :chromosomes
  end
end
