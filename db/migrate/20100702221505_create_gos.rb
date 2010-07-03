class CreateGos < ActiveRecord::Migration
  def self.up
    create_table :gos do |t|
      t.string :term
      t.string :category
    end
  end

  def self.down
    drop_table :gos
  end
end
