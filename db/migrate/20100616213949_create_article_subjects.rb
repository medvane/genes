class CreateArticleSubjects < ActiveRecord::Migration
  def self.up
    create_table :article_subjects do |t|
      t.integer :article_id
      t.integer :subject_id
    end
    add_index :article_subjects, :article_id
  end

  def self.down
    drop_table :article_subjects
  end
end
