# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100617143236) do

  create_table "article_subjects", :force => true do |t|
    t.integer "article_id"
    t.integer "subject_id"
  end

  add_index "article_subjects", ["article_id"], :name => "index_article_subjects_on_article_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gene_subjects", :force => true do |t|
    t.integer "gene_id"
    t.integer "subject_id"
    t.integer "articles_count"
  end

  add_index "gene_subjects", ["gene_id", "articles_count"], :name => "index_gene_subjects_on_gene_id_and_articles_count"
  add_index "gene_subjects", ["subject_id", "articles_count"], :name => "index_gene_subjects_on_subject_id_and_articles_count"

  create_table "genes", :force => true do |t|
    t.integer "taxonomy_id"
    t.string  "symbol"
    t.string  "name"
    t.string  "chromosome"
    t.string  "map_location"
    t.integer "articles_count", :default => 0
    t.integer "start_position"
    t.integer "end_position"
  end

  add_index "genes", ["articles_count"], :name => "index_genes_on_articles_count"
  add_index "genes", ["symbol"], :name => "index_genes_on_symbol"

  create_table "homologenes", :force => true do |t|
    t.integer "gene_id"
    t.integer "homolog_id"
  end

  add_index "homologenes", ["gene_id", "homolog_id"], :name => "index_homologenes_on_gene_id_and_homolog_id"

  create_table "published_genes", :force => true do |t|
    t.integer "article_id"
    t.integer "gene_id"
  end

  add_index "published_genes", ["article_id"], :name => "index_published_genes_on_article_id"
  add_index "published_genes", ["gene_id"], :name => "index_published_genes_on_gene_id"

  create_table "reviewed_genes", :force => true do |t|
    t.integer "review_id"
    t.integer "gene_id"
    t.integer "taxonomy_id"
    t.string  "chromosome"
    t.integer "articles_count",                                :default => 0
    t.decimal "specificity",     :precision => 5, :scale => 2
    t.text    "article_id_list"
  end

  add_index "reviewed_genes", ["gene_id", "articles_count"], :name => "index_reviewed_genes_on_gene_id_and_articles_count"
  add_index "reviewed_genes", ["review_id", "articles_count"], :name => "index_reviewed_genes_on_review_id_and_articles_count"
  add_index "reviewed_genes", ["review_id", "gene_id", "articles_count"], :name => "index_reviewed_genes_on_review_id_and_gene_id_and_articles_count"
  add_index "reviewed_genes", ["review_id", "specificity", "articles_count"], :name => "index_reviewed_genes_on_review_specificity_articles_count"
  add_index "reviewed_genes", ["review_id", "taxonomy_id", "chromosome", "articles_count"], :name => "index_reviewed_genes_on_review_taxonomy_chromosome"

  create_table "reviews", :force => true do |t|
    t.string   "search_term"
    t.string   "title"
    t.integer  "search_results_count", :default => 0
    t.integer  "genes_count",          :default => 0
    t.integer  "articles_count",       :default => 0
    t.integer  "hits",                 :default => 0
    t.boolean  "built",                :default => false
    t.datetime "built_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["built", "hits"], :name => "index_reviews_on_built_and_hits"

  create_table "subjects", :force => true do |t|
    t.string "term"
  end

  add_index "subjects", ["term"], :name => "index_subjects_on_term"

  create_table "taxonomies", :force => true do |t|
    t.string  "scientific_name"
    t.integer "genes_count",     :default => 0
  end

end
