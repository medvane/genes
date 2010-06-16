class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :term
    end
    add_index :subjects, :term
  end

  def self.down
    drop_table :subjects
  end
end
