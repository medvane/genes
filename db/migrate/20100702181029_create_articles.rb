class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.text :title
      t.string :source
      t.date :pubdate
    end
  end

  def self.down
    drop_table :articles
  end
end
