class CreateGos < ActiveRecord::Migration
  def self.up
    create_table :gos do |t|
      t.string :term
      t.string :category, :limit => 9
    end
    add_index :gos, :category
  end

  def self.down
    drop_table :gos
  end
end
