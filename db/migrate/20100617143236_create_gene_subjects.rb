class CreateGeneSubjects < ActiveRecord::Migration
  def self.up
    create_table :gene_subjects do |t|
      t.integer :gene_id
      t.integer :subject_id
      t.integer :articles_count
    end
    add_index :gene_subjects, [:gene_id, :articles_count]
    add_index :gene_subjects, [:subject_id, :articles_count]
  end

  def self.down
    drop_table :gene_subjects
  end
end
