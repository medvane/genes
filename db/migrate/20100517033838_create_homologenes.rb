class CreateHomologenes < ActiveRecord::Migration
  def self.up
    create_table :homologenes do |t|
      t.integer :homolog_id
      t.integer :gene_id
    end
    add_index :homologenes, :homolog_id
    add_index :homologenes, :gene_id
  end

  def self.down
    drop_table :homologenes
  end
end
