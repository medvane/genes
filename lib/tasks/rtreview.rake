require 'zlib'
require 'open-uri'
namespace :rtreview do
  namespace :update do
    desc "update Taxonomy, Gene, PublishedGene"
    task :all => :environment do
      ['taxonomy', 'published_gene', 'gene', 'homologene'].each do |task|
        Rake::Task["rtreview:update:#{task}"].invoke
      end
    end

    desc "update Taxonomy"
    task :taxonomy => :environment do
      tmpfile = tempfile("taxonomies.dat")
      File.open(tmpfile, "w") do |file|
        progress("downloading taxdump.tar.gz")
        gz = download_gz("ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz")
        progress("writing #{tmpfile}")
        gz.each_line do |line|
          tax_id, name_txt, unique_name, name_class  = line.split(/\s*\|\s*/)
          if name_class == 'scientific name'
            file.write("#{tax_id}\t#{name_txt}\n")
          end
        end
      end
      load_data(tmpfile)
      progress("updated Taxonomy")
    end

    desc "update Gene"
    task :gene => :environment do
      tmpfile = tempfile("genes.dat")
      countfile = tempfile("gene_articles_count.txt")
      count = {}
      File.open(countfile, "r") do |file|
        progress("reading #{countfile}")
        file.each_line do |line|
          gene_id, articles_count = line.strip.split(/\t/)
          count[gene_id] = articles_count
        end
      end
      File.open(tmpfile, "w") do |file|
        progress("downloading gene_info.gz")
        gz = download_gz("ftp://ftp.ncbi.nih.gov/gene/DATA/gene_info.gz")
        progress("writing #{tmpfile}")
        gz.each_line do |line|
          taxonomy_id, gene_id, symbol, locusTag, synonyms, dbXrefs, chromosome, map_location, description, type_of_gene, symbol_from_nomenclature_authority, full_name_from_nomenclature_authority, nomenclature_status, other_designations, modification_date = line.split(/\t/)
          articles_count = count[gene_id] || 0
          file.write("#{gene_id}\t#{taxonomy_id}\t#{symbol}\t#{description}\t#{chromosome}\t#{map_location}\t#{articles_count}\n") if gz.lineno > 1
        end
      end
      load_data(tmpfile)
      progress("updated Gene")
    end

    desc "update PublishedGene"
    task :published_gene => :environment do
      tmpfile = tempfile("published_genes.dat")
      countfile = tempfile("gene_articles_count.txt")
      count = {}
      File.open(tmpfile, "w") do |file|
        progress("downloading gene2pubmed.gz")
        gz = download_gz("ftp://ftp.ncbi.nih.gov/gene/DATA/gene2pubmed.gz")
        progress("writing #{tmpfile}")
        gz.each_line do |line|
          tax_id, gene_id, article_id = line.strip.split(/\t/)
          if gz.lineno > 1
            file.write("#{gz.lineno}\t#{article_id}\t#{gene_id}\n")
            count[gene_id] ||= 0
            count[gene_id] += 1
          end
        end
      end
      load_data(tmpfile)
      File.open(countfile, "w") do |file|
        progress("writing #{countfile}")
        count.keys.each do |gene_id|
          file.write("#{gene_id}\t#{count[gene_id]}\n")
        end
      end
      progress("updated PublishedGene")
    end

    desc "update Homologene"
    task :homologene => :environment do
      tmpfile = tempfile("homologenes.dat")
      File.open(tmpfile, "w") do |file|
        progress("downloading homologene.data")
        open("ftp://ftp.ncbi.nih.gov/pub/HomoloGene/current/homologene.data") do |f|
          progress("writing #{tmpfile}")
          f.each_line do |line|
            homologene_id, tax_id, gene_id, symbol, gi, locus_version = line.strip.split(/\t/)
            file.write("#{f.lineno}\t#{homologene_id}\t#{gene_id}\n")
          end
        end
      end
      load_data(tmpfile)
      progress("updated Homologene")
    end
  end

  def download_gz(url)
    Zlib::GzipReader.new(open(url))
  end

  def tempfile(file_name)
    File.join(Rails.root, "tmp", file_name)
  end

  def load_data(file)
    table_name = File.basename(file, ".dat")
    quoted_table_name = quote_table_name(table_name)
    file_size = File.size(file)
    if file_size > 0
      progress("loading #{file_size} byte data into #{table_name}")
      execute("TRUNCATE TABLE #{quoted_table_name}")
      execute("ALTER TABLE #{quoted_table_name} DISABLE KEYS")
      execute("LOAD DATA LOCAL INFILE '#{file}' INTO TABLE #{quoted_table_name}")
      progress("adding index to #{quoted_table_name}")
      execute("ALTER TABLE #{quoted_table_name} ENABLE KEYS")
    end
  end

  def execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

  def quote_table_name(table_name)
    ActiveRecord::Base.connection.quote_table_name(table_name)
  end

  def progress(message)
    puts "[#{Time.now.to_s}] #{message}"
  end
end