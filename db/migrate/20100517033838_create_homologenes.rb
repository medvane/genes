class CreateHomologenes < ActiveRecord::Migration
  def self.up
    create_table :homologenes do |t|
      t.integer :gene_id
      t.integer :homolog_id
    end
    add_index :homologenes, [:gene_id, :homolog_id]
  end

  def self.down
    drop_table :homologenes
  end
end
