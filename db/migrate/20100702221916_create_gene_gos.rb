class CreateGeneGos < ActiveRecord::Migration
  def self.up
    create_table :gene_gos do |t|
      t.integer :gene_id
      t.integer :go_id
    end
    add_index :gene_gos, :gene_id
  end

  def self.down
    drop_table :gene_gos
  end
end
