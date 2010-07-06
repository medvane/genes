class CreateReviewedGos < ActiveRecord::Migration
  def self.up
    create_table :reviewed_gos do |t|
      t.integer :review_id
      t.integer :go_id
      t.integer :genes_count, :default => 0
    end
    add_index :reviewed_gos, [:review_id, :genes_count]
  end

  def self.down
    drop_table :reviewed_gos
  end
end
